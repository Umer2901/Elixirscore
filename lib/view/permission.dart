import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  static const platform = MethodChannel('com.elixir.elixirscore/deviceActivity');

  final Map<String, bool> permissions = {
    'Apple Health': false,
    'Notification': false,
    'Screen Time': false,
  };

  @override
  void initState() {
    super.initState();
    _checkInitialPermissions();
  }

  void _checkInitialPermissions() async {
    final healthStatus = await _checkHealthPermission();
    final notificationStatus = await Permission.notification.status;
    // Assume false for Screen Time initially
    setState(() {
      permissions['Apple Health'] = healthStatus;
      permissions['Notification'] = notificationStatus.isGranted;
      permissions['Screen Time'] = false; // Placeholder until permission is granted
    });
  }

  Future<bool> _checkHealthPermission() async {
    HealthFactory health = HealthFactory();
    bool accessGranted = await health.requestAuthorization([HealthDataType.HEART_RATE]);
    return accessGranted;
  }

  Future<void> _showCustomBottomSheet(
      BuildContext context, String permissionKey, String heading, String detail) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    heading,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 18.sp),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const CircleAvatar(
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.close),
                    ),
                  )
                ],
              ),
              SizedBox(height: 1.h),
              Text(
                detail,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    label: "Enable",
                    onPressed: () async {
                      await _requestPermission(permissionKey);
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 1.h),
                  CustomButton(
                    label: "Cancel",
                    borderColor: AppColors.white,
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.black,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _requestPermission(String permissionKey) async {
    PermissionStatus status;
    switch (permissionKey) {
      case 'Apple Health':
        bool accessGranted = await _checkHealthPermission();
        setState(() {
          permissions['Apple Health'] = accessGranted;
        });
        break;
      case 'Notification':
        status = await Permission.notification.request();
        setState(() {
          permissions['Notification'] = status.isGranted;
        });
        break;
      case 'Screen Time':
        await _startScreenTimeMonitoring();
        break;
      default:
        return;
    }
  }

  Future<void> _startScreenTimeMonitoring() async {
    try {
      await platform.invokeMethod('startMonitoring');
      print("Screen time monitoring started.");
      setState(() {
        permissions['Screen Time'] = true;
      });
      _getUsageData(); // Fetch initial screen time usage data
    } on PlatformException catch (e) {
      print("Failed to start monitoring: '${e.message}'.");
    }
  }

  Future<void> _getUsageData() async {
    try {
      final String usage = await platform.invokeMethod('getUsageData');
      print("Retrieved screen time: $usage");
      double screenTime = double.tryParse(usage.split(' ').first) ?? 0.0;
      setState(() {
        permissions['Screen Time'] = true; // Permission granted and data retrieved
      });
    } on PlatformException catch (e) {
      print("Failed to get usage data: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 6.h),
              Center(
                child: Text(
                  'Health Sync',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(height: 1.h),
              Center(
                child: Text(
                  "Please give the app all permissions",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
              SizedBox(height: 6.h),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildPermissionCard(
                      context,
                      'Apple Health',
                      '❤️',
                      'The Health app gathers health data from your iPhone, iPad, Apple Watch, and apps that you already use, so you can view all your progress in one convenient place. Health automatically counts your steps, walking, and running distances. And, if you have an Apple Watch, it automatically tracks your Activity data.',
                    ),
                    SizedBox(height: 2.h),
                    _buildPermissionCard(
                      context,
                      'Notification',
                      '🔔',
                      'To help you keep track of your health data over time, Health can alert you to significant changes in types of data like resting heart rate, number of steps, and amount of sleep. Trend lines show you how much these metrics have changed and for how long.',
                    ),
                    SizedBox(height: 2.h),
                    _buildPermissionCard(
                      context,
                      'Screen Time',
                      '📱️',
                      'Screen time is the amount of time spent using a device with a screen such as a smartphone, computer, television, video game console, or even a tablet. The concept is under significant research with related concepts in digital media use and mental health',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_allPermissionsGranted()) {
              Get.toNamed(AppRoutes.dashboard);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enable all permissions before proceeding.')),
              );
            }
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward, color: AppColors.white),
        ),
      );
    });
  }

  bool _allPermissionsGranted() {
    return permissions.values.every((permission) => permission);
  }

  Widget _buildPermissionCard(
      BuildContext context, String permissionKey, String emoji, String detail) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: permissions[permissionKey] == true ? AppColors.primary : AppColors.grey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 1.h),
            Text(
              '$permissionKey                 $emoji',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 18.sp,
                  ),
            ),
            SizedBox(height: 2.h),
            CustomButton(
              height: 6.h,
              label: permissions[permissionKey] == true ? "Enabled" : "Enable",
              onPressed: permissions[permissionKey] == true
                  ? () {} // Provide an empty function if the permission is already enabled
                  : () {
                      _showCustomBottomSheet(context, permissionKey, permissionKey, detail);
                    },
            )
          ],
        ),
      ),
    );
  }
}
