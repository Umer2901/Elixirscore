// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/health_provider.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';

import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const platform = MethodChannel('com.elixir.elixirscore/deviceActivity');

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _startMonitoring();
  }

  // Start screen time monitoring
  Future<void> _startMonitoring() async {
    try {
      await platform.invokeMethod('startMonitoring');
      print("Screen time monitoring started.");
      _getUsageData();
    } on PlatformException catch (e) {
      print("Failed to start monitoring: '${e.message}'.");
    }
  }

  // Get the screen time usage data and update the HealthDataProvider
  Future<void> _getUsageData() async {
    try {
      final String usage = await platform.invokeMethod('getUsageData');
      print("Retrieved screen time: $usage");

      // Assuming the usage data is in minutes, convert to a double value
      double screenTime = double.tryParse(usage.split(' ').first) ?? 0.0;

      // Update the HealthDataProvider with the screen time value
      Provider.of<HealthDataProvider>(context, listen: false).screenTime = screenTime;
      Provider.of<HealthDataProvider>(context, listen: false).screenTimeScore =
          Provider.of<HealthDataProvider>(context, listen: false).calculateScreenTimeScore(screenTime);

      // Notify listeners to update UI or data dependencies
      Provider.of<HealthDataProvider>(context, listen: false).notifyListeners();
    } on PlatformException catch (e) {
      print("Failed to get usage data: '${e.message}'.");
    }
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 3));
    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);

    if (isLoggedIn) {
      Get.offAndToNamed(AppRoutes.dashboard); // Navigate to Dashboard if logged in
    } else {
      Get.offAndToNamed(AppRoutes.signin); // Navigate to SignIn if not logged in
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              AppImages.logo,
              width: 50.w,
              height: 50.h,
            ),
            Consumer<LoadingProvider>(
              builder: (context, loader, _) {
                return loader.isLoading
                    ? SpinKitCircle(
                        size: 70.sp,
                        color: AppColors.black,
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
