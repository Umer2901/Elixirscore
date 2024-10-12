
import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  bool isLoading = false;
  late String verificationId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = Get.arguments;
    if (args != null && args is String) {
      verificationId = args;
    } else {
      // Handle the case where the verificationId is not passed correctly
    //  Get.back();
    }
  }

  void _showSnackbar(String message, {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }

  Widget _buildPinInputField(AuthProvider authProvider) {
    return Padding(
      padding: EdgeInsets.all(5.sp),
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
          autoFocus: true,
          onChanged: (String pin) async {
            setState(() {
              otp = pin;
            });

            // Automatically verify the OTP when all 6 digits are entered
            if (otp.length == 6) {
              await _verifyOtp(authProvider);
            }
          },
        ),
      ),
    );
  }

  Future<void> _verifyOtp(AuthProvider authProvider) async {
    if (otp.length < 6 || isLoading) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      // Verify OTP using the authProvider
      await authProvider.verifyOtp(context, verificationId, otp);
    } catch (e) {
      _showSnackbar('Verification failed: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildResendCodeButton(AuthProvider authProvider) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          if (isLoading) return;

          try {
            setState(() {
              isLoading = true;
            });
            await authProvider.resendOtp(context);
            _showSnackbar('Code resent', backgroundColor: AppColors.primary);
          } catch (e) {
            _showSnackbar('Failed to resend code: $e');
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Text(
          'Resend Code',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primary,
              ),
        ),
      ),
    );
  }

 Widget _buildVerifyButton(AuthProvider authProvider) {
  return CustomButton(
    isLoading: isLoading,
    label: "Verify",
    onPressed: () async {
      if (otp.length < 6) {
        _showSnackbar('Please enter the full code');
        return;
      }

      try {
        setState(() {
          isLoading = true;
        });
        await authProvider.verifyOtp(context, verificationId, otp);
      } catch (e) {
        _showSnackbar('Verification failed: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                  'Enter the Code',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(height: 3.h),
                Text(
                  "Enter 6 digit verification code sent to your phone number",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 3.h),
                _buildPinInputField(authProvider),
                SizedBox(height: 2.h),
                _buildResendCodeButton(authProvider),
                SizedBox(height: 2.h),
                _buildVerifyButton(authProvider),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
