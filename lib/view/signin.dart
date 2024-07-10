import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/forgot.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return  Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Center(child: Image.asset(AppImages.logo,height: 30.h,width: 50.w,)),
                 Text(
                           "Email Address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
            
                                ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
               const CustomTextField(
                name: "email",
                hintText: "Email Address",
                prefixIcon: Icon(Icons.email_outlined),
                ),
                SizedBox(
                            height: 1.h,
                          ),
                Text(
                           "Password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
            
                                ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
               const CustomTextField(
                name: "Password",
                hintText: "Password",
                obscureText: true,
                prefixIcon: Icon(Icons.lock_outlined),
                suffixIcon: Icon(Icons.visibility),
                ),
                 SizedBox(
                            height: 1.h,
                          ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     GestureDetector(
                      onTap: (){
                       Get.to(() => const ForgotScreen());
                      },
                       child: Text(
                                 "Forgotton Password?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                 fontWeight: FontWeight.bold
                                      ),
                                ),
                     ),
                   ],
                 ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CustomButton(
                            label: "Sign In", 
                            onPressed: (){
                              Get.offAndToNamed(AppRoutes.phoneAuth);
                            }),
                            SizedBox(
                            height: 3.h,
                          ),
                             Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: AppColors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.sp),
                      child: Text(
                        'OR',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: AppColors.grey,
                        thickness: 1,
                      ),
                    ),
                    
                  ],
                ),
                 SizedBox(
                  height: 8.h,
                      width: double.infinity,
                      child: Image.asset(AppImages.apple),
                    ),
                    SizedBox(
                  height: 8.h,
                      width: double.infinity,
                      child: Image.asset(AppImages.google),
                    ),
                     SizedBox(
                            height: 4.h,
                          ),
                     Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: GestureDetector(
                      onTap: () {
                       Get.toNamed(AppRoutes.signup);
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold,color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),)))
              ],
            ),
          ),
        ),
      );
  });
  }
}