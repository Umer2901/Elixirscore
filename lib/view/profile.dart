import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   @override
  void initState() {
    super.initState();
    _loadBasicInfo();
  }

  Future<void> _loadBasicInfo() async {
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context, listen: false);
    await basicInfoProvider.loadBasicInfo();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '       Profile',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
             Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey, width: 2),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 3.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text('Azeem Iftikhar',
                //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                //         fontWeight: FontWeight.bold, fontSize: 18.sp)),
                 Text(
                  basicInfoProvider.basicInfo?.email ?? 'Loading...',
                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 4.h),
                GestureDetector(
                    onTap: () {
                    Get.toNamed(AppRoutes.accountinfo);
                  },
               child:  Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Account Details',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp)),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),),
                SizedBox(
                  height: 2.h,
                ),
                 GestureDetector(
                    onTap: () {
                    Get.toNamed(AppRoutes.updatebasicinfo);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Edit Basic Info',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp)),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.termandservices);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Term of Services',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp)),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                    onTap: () {
                    Get.toNamed(AppRoutes.privacy);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Privacy Policy',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp)),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Contact us',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp)),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomButton(
                  label: "Donate",
                  onPressed: () {},
                  backgroundColor: Colors.amber,
                  borderColor: Colors.amber,
                )
              ],
            ),
          ),
        ),
      ),
     floatingActionButton: Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  decoration: const BoxDecoration(
    color: Colors.transparent,
  ),
  child: GestureDetector(
    onTap: () async {
      await authProvider.signOut(context);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      Get.offAllNamed(AppRoutes.signin);
    },
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Logout",
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 23),
        ),
        SizedBox(width: 5),
        Icon(Icons.exit_to_app, color: AppColors.primary),
      ],
    ),
  ),
),

    );
  }
}
