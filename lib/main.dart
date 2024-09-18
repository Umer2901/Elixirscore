import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:flutter_application_elixirscore/providers/health_provider.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:health/health.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => BasicInfoProvider()),
        ChangeNotifierProvider(create: (_) => HealthDataProvider()),
      ],
     
       
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ElixirScore',
          theme: ThemeData(
                scaffoldBackgroundColor: AppColors.white,
                textTheme: TextTheme(
                  displaySmall: GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  headlineLarge: GoogleFonts.montserrat(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  headlineMedium: GoogleFonts.montserrat(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  headlineSmall: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  bodyLarge: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  bodyMedium: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                  bodySmall: GoogleFonts.montserrat(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                ),
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
                useMaterial3: true,
              ),
             // home: const PhoneAuth(),
          initialRoute: AppPages.initialRoute,
           getPages: AppPages.routes,
          )  );
      }
    );
  }
}
