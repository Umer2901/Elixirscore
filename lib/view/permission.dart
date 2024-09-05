import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:health/health.dart';
//import 'package:screen_time_api_ios/screen_time_api_ios.dart';
import 'package:sizer/sizer.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  _PermissionScreenState createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  final Map<String, bool> permissions = {
    'Apple Health': false,
    'Notification': false,
    'Screen Time': false,
  };

  @override
  void initState() {
    super.initState();
    // Initialize permission status
    _checkInitialPermissions();
  }

  void _checkInitialPermissions() async {
    final healthStatus = await _checkHealthPermission();
    final notificationStatus = await Permission.notification.status;
    
    setState(() {
      permissions['Apple Health'] = healthStatus;
      permissions['Notification'] = notificationStatus.isGranted;
      // Handle Screen Time permission status here if available
    });
  }

  Future<bool> _checkHealthPermission() async {
    HealthFactory health = HealthFactory();
    bool accessGranted = await health.requestAuthorization([HealthDataType.HEART_RATE]);
    return accessGranted;
  }

  void showCustomPanel(BuildContext context, String permissionKey, String heading, String detail) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: AppColors.grey,
              ),
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: controller,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 18.sp
                        )
                      ),
                      IconButton(onPressed: (){ Navigator.of(context).pop();}, icon: const CircleAvatar(backgroundColor:AppColors.white,child: Icon(Icons.close)))
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
                      SizedBox(
                        height: 1.h,
                      ),
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
        // This plugin method doesn't request permissions directly
      //  final _screenTimeApiIosPlugin = ScreenTimeApiIos();
        // Assuming there's no direct permission request; handle accordingly
       // _screenTimeApiIosPlugin.selectAppsToDiscourage();
        setState(() {
          permissions['Screen Time'] = true; // Assume successful operation
        });
        break;
      default:
        return;
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
              SizedBox(
                height: 6.h,
              ),
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
              SizedBox(
                height: 6.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildPermissionCard(
                      context,
                      'Apple Health',
                      '❤️',
                      'The Health app gathers health data from your iPhone',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _buildPermissionCard(
                      context,
                      'Notification',
                      '🔔',
                      'To help you keep track of your health data...',
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _buildPermissionCard(
                      context,
                      'Screen Time',
                      '📱️',
                      'Screen time is the amount of time spent using a device...',
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
                SnackBar(content: Text('Please enable all permissions before proceeding.')),
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
          SizedBox(
            height: 1.h,
          ),
          Text(
            '$permissionKey                 $emoji',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
          ),
          SizedBox(
            height: 2.h,
          ),
          CustomButton(
            height: 6.h,
            label: permissions[permissionKey] == true ? "Enabled" : "Enable",
            onPressed: permissions[permissionKey] == true
                ? () {}  // Provide an empty function if the permission is already enabled
                : () {
                    showCustomPanel(
                        context, permissionKey, permissionKey, detail);
                  },
          )
        ],
      ),
    ),
  );
}
}
