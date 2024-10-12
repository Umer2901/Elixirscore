import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final TextEditingController _emailController = TextEditingController();
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
                  CustomTextField(
                  keyboardType: TextInputType.text,
                  controller: _emailController,
                  name: 'email',
                  hintText: 'Your email',
                  fillColor: AppColors.white,
                ),
               
                SizedBox(height: 3.h),
              
                 Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, child) {
                    return loadingProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            onPressed: () async {
                              final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
                              loadingProvider.setLoading(true);
                              final authProvider = Provider.of<AuthProvider>(context, listen: false);
                              await authProvider.sendPasswordResetEmail(context, _emailController.text);
                              loadingProvider.setLoading(false);
                             await Future.delayed(const Duration(seconds: 3));
                             Get.toNamed(AppRoutes.signin);
                            }, label:  'Send Code',
                          );
                  },
                ),
                
                 SizedBox(height: 42.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 2.h),
                    child: GestureDetector(
                      onTap: (){
                          Get.toNamed(AppRoutes.signin);
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