import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Padding(
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
                  'Forgot password?',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'Don’t worry! It happens. Please enter the email associated with your account.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 4.h),
                Text(
                  'Email Address',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                  SizedBox(height: 1.h),
                const CustomTextField(
                  name: 'email',
                  hintText: 'Your email',
                  fillColor: AppColors.white,
                ),
               
                SizedBox(height: 3.h),
              
              CustomButton(label: "Send Email", onPressed: (){}),
                
                 SizedBox(height: 42.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: GestureDetector(
                      onTap: (){
                         
                      },
                      child: Text.rich(
                        TextSpan(
                          text: 'Remember Password? ',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                          children: <InlineSpan>[
                            TextSpan(
                              text: 'Login Now',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}