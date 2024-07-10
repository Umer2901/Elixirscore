import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Two factor Authentication',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please confirm your country code and enter your phone number.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 4.h),
                SizedBox(height: 1.h),
                const Divider(height: 1),
                Row(
                  children: [
                    Image.asset(
                      AppImages.usa,
                      height: 6.h,
                      width: 10.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'USA',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                const Divider(height: 1),
                
                Row(
                  children: [
                    Text(
                      '+1   |',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Expanded(
                      child: CustomTextField(
                        name: "otp",
                        hintText: "12345678",
                        borderColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
               
                const Divider(height: 1),
                SizedBox(height: 3.h),
                CustomButton(label: "Continue", onPressed: () {
                   Get.toNamed(AppRoutes.otp);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
