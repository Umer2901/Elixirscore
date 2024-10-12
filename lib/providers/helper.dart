import 'package:flutter/services.dart';

class DeviceActivityHelper {
  static const platform = MethodChannel('com.elixir.elixirscore/deviceActivity');

  // Start monitoring app usage
  Future<void> startMonitoring() async {
    try {
      final result = await platform.invokeMethod('startMonitoring');
      print("Success: $result"); // Log success message
    } on PlatformException catch (e) {
      print("Failed to start monitoring: ${e.message}"); // Log error
    }
  }

  // Get usage data
  Future<void> getUsageData() async {
    try {
      final usageData = await platform.invokeMethod('getUsageData');
      print("Usage data: $usageData"); // Log the usage data
    } on PlatformException catch (e) {
      print("Failed to get usage data: ${e.message}"); // Log error
    }
  }
}
