

import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/basicinfo.dart';
import 'package:flutter_application_elixirscore/view/dashboard.dart';
import 'package:flutter_application_elixirscore/view/forgot.dart';
import 'package:flutter_application_elixirscore/view/otp.dart';
import 'package:flutter_application_elixirscore/view/permission.dart';
import 'package:flutter_application_elixirscore/view/phoneauth.dart';
import 'package:flutter_application_elixirscore/view/profile.dart';
import 'package:flutter_application_elixirscore/view/profile/account_info.dart';
import 'package:flutter_application_elixirscore/view/profile/privacy.dart';
import 'package:flutter_application_elixirscore/view/profile/term_of_services.dart';
import 'package:flutter_application_elixirscore/view/profile/update_basic_info.dart';
import 'package:flutter_application_elixirscore/view/signin.dart';
import 'package:flutter_application_elixirscore/view/signup.dart';
import 'package:flutter_application_elixirscore/view/splash.dart';
import 'package:get/get.dart';

class AppPages extends AppRoutes {
  static const String initialRoute = AppRoutes.splash;
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
     GetPage(
      name: AppRoutes.signin,
      page: () => const Signin(),
    ),
     GetPage(
      name: AppRoutes.signup,
      page: () => const Signup(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgotScreen(),
    ),
     GetPage(
      name: AppRoutes.phoneAuth,
      page: () => const PhoneAuth(),
    ),
     GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: AppRoutes.basicinfo,
      page: () => const BasicInfo(),
    ),
     GetPage(
      name: AppRoutes.permission,
      page: () => const PermissionScreen(),
    ),
     GetPage(
      name: AppRoutes.dashboard,
      page: () => const Dashboard(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
     GetPage(
      name: AppRoutes.termandservices,
      page: () => TermsAndServices(),
    ),
     GetPage(
      name: AppRoutes.privacy,
      page: () => Privacy(),
    ),
    GetPage(
      name: AppRoutes.updatebasicinfo,
      page: () => const UpdateBasicInfo(),
    ),
     GetPage(
      name: AppRoutes.accountinfo,
      page: () => const AccountInfo(),
    ),
    
  ];
}