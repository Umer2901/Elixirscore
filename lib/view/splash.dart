
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
    Provider.of<LoadingProvider>(context, listen: false).setLoading(false);
    Get.offAndToNamed(AppRoutes.signin);
    });
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
                    ?  SpinKitCircle(
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