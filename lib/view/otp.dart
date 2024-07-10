import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool obsecurePassword = true;
  String otp = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
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
                  'Enter the code',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 3.h),
                Text("Enter 6 digit verification code sent to your phone number",
                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                 ),
                SizedBox(height: 3.h),
                
               Padding(
                 padding:  EdgeInsets.all(5.sp),
                 child: SizedBox(
                  height: 6.h,              
                   child: PinInputTextField(
                      pinLength: 6,
                      decoration: BoxLooseDecoration(
                        strokeWidth: 1,
                        strokeColorBuilder: PinListenColorBuilder(
                          AppColors.grey, 
                          AppColors.black, 
                        ),
                      ),
                      
                    
                      onSubmit: (String pin) {
                        setState(() {
                          otp = pin;
                        });
                      },
                    ),
                 ),
               ),
                SizedBox(height: 2.h),
                 Center(
                   child: Text(
                    'Resend Code',
                    style: Theme.of(context).textTheme.bodyLarge   ?.copyWith(
            color: AppColors.primary
                                ),
                                   ),
                 ),
                  SizedBox(height: 2.h),
               CustomButton(label: "Verify", onPressed: (){
                Get.toNamed(AppRoutes.basicinfo);
               }),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}