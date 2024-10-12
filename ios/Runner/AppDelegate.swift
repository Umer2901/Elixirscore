import UIKit
import Flutter
import FirebaseCore
import Firebase
import DeviceActivity
import FamilyControls

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var totalAppUsageTimeInMinutes = 0 // Store total usage time
    var activityName = DeviceActivityName("monitoredAppsActivity")

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Initialize Firebase
        FirebaseApp.configure()
        
        // Register generated Flutter plugins
        GeneratedPluginRegistrant.register(with: self)
        
        // Set up platform channel for communication between Flutter and native iOS
        let controller = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.elixir.elixirscore/deviceActivity", binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "startMonitoring" {
                self?.requestAuthorization(result: result) // Request authorization before starting monitoring
            } else if call.method == "getUsageData" {
                self?.getUsageData(result: result) // Retrieve usage data
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Request authorization for Family Controls (necessary for monitoring apps)
    private func requestAuthorization(result: @escaping FlutterResult) {
        let authorizationCenter = AuthorizationCenter.shared
        
        // Use async-await for requesting authorization
        Task {
            do {
                try await authorizationCenter.requestAuthorization(for: .individual)
                print("Authorization granted")
                self.startMonitoring(result: result)  // Start monitoring if authorized
            } catch {
                print("Authorization failed: \(error.localizedDescription)")
                result(FlutterError(code: "AUTHORIZATION_FAILED", message: "Failed to get authorization", details: error.localizedDescription))
            }
        }
    }
    
    // Start monitoring apps using Family Controls and Device Activity
    private func startMonitoring(result: @escaping FlutterResult) {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0), // Start at midnight
            intervalEnd: DateComponents(hour: 23, minute: 59), // End at 11:59 PM
            repeats: true // Set to repeat daily
        )
        
        // Create a DeviceActivityCenter for monitoring device usage
        let center = DeviceActivityCenter()
        
        do {
            try center.startMonitoring(activityName, during: schedule)
            print("Monitoring started successfully")
            result("Monitoring started successfully")
            
            // Start updating app usage time
            self.startTrackingAppUsage()
            
        } catch {
            print("Failed to start monitoring: \(error.localizedDescription)")
            result(FlutterError(code: "START_MONITORING_FAILED", message: "Failed to start monitoring", details: error.localizedDescription))
        }
    }
    
    // Start tracking app usage in the background
    private func startTrackingAppUsage() {
        Timer.scheduledTimer(withTimeInterval: 60.0, repeats: true) { [weak self] timer in
            // Increment the total usage time every minute
            self?.totalAppUsageTimeInMinutes += 1
            print("Total app usage time: \(self?.totalAppUsageTimeInMinutes ?? 0) minutes")
        }
    }
    
    // Retrieve the total app usage time (in minutes)
    private func getUsageData(result: @escaping FlutterResult) {
        result("Total app usage time: \(totalAppUsageTimeInMinutes) minutes")
    }
}
