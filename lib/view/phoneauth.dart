// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController _phoneNumberController = TextEditingController();
  bool isLoading = false;

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
                  'Two Factor Authentication',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Please enter your phone number.',
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
                      '+1   ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: _phoneNumberController,
                        name: "Phone Number",
                        hintText: "Enter phone number",
                        borderColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
                SizedBox(height: 3.h),
                CustomButton(
                  isLoading: isLoading,
                  label: "Continue",
                  onPressed: () async {
                    if (_phoneNumberController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a phone number')),
                      );
                      return;
                    }
                    
                    setState(() {
                      isLoading = true;
                    });

                    final phoneNumber = '+1${_phoneNumberController.text}';
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    
                    try {
                      await authProvider.verifyPhoneNumber(context, phoneNumber);
                     

   
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification failed: $e')),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
