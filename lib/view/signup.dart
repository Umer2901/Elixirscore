// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;
  bool isLoading = false;

  Future<void> _setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset(AppImages.logo, height: 30.h, width: 50.w)),
                   Text(
                    "Email Address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: _emailController,
                    name: "email",
                    hintText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Password",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: _passwordController,
                    name: "Password",
                    hintText: "Password",
                    obscureText: _obsecurePassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obsecurePassword = !_obsecurePassword;
                        });
                      },
                      child: Icon(
                        _obsecurePassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    "Password Confirmation",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    name: "Confirm Password",
                    hintText: "Confirm Password",
                    obscureText: _obsecureConfirmPassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _obsecureConfirmPassword = !_obsecureConfirmPassword;
                        });
                      },
                      child: Icon(
                        _obsecureConfirmPassword
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  CustomButton(
                    isLoading: isLoading,
                    label: "Sign Up",
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      if (_passwordController.text != _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Passwords do not match')),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        return;
                      }

                      final authProvider = Provider.of<AuthProvider>(context, listen: false);
                      try {
                        await authProvider.registerWithEmailAndPassword(
                          context,
                          _emailController.text,
                          _passwordController.text,
                        );

                        if (authProvider.user != null) {
                          await _setLoginStatus(true);
                         // Get.offAndToNamed(AppRoutes.dashboard);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registration failed. Please try again.')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration failed: $e')),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signin);
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Signin',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
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
        );
      },
    );
  }
}
