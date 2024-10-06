import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/auth_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/forgot.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obsecurePassword = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
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
                  SizedBox(height: 1.h),
                  CustomTextField(
                    controller: _emailController,
                    keyboardType: TextInputType.text,
                    name: "email",
                    hintText: "Email Address",
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  SizedBox(height: 1.h),
                  CustomTextField(
                      keyboardType: TextInputType.text,
                    controller: _passwordController,
                    name: "Password",
                    hintText: "Password",
                    obscureText: obsecurePassword,
                    prefixIcon: const Icon(Icons.lock_outlined),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obsecurePassword = !obsecurePassword;
                        });
                      },
                      child: Icon(
                        obsecurePassword ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const ForgotScreen());
                        },
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  CustomButton(
                    isLoading: isLoading,
                    label: "Sign In",
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final authProvider = Provider.of<AuthProvider>(context, listen: false);
                      try {
                        await authProvider.loginWithEmailAndPassword(
                          context,
                          _emailController.text,
                          _passwordController.text,
                        );
                      
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')),
                        );
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 3.h),
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
                  GestureDetector(
                       onTap: () async {
                       final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          await authProvider.signInWithApple(context);

                      
                    },
                    child: SizedBox(
                      height: 8.h,
                      width: double.infinity,
                      child: Image.asset(AppImages.apple),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                       final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          await authProvider.signInWithGoogle(context);

                          
                    },
                    child: SizedBox(
                      height: 8.h,
                      width: double.infinity,
                      child: Image.asset(AppImages.google),
                    ),
                  ),
                  SizedBox(height: 4.h),
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
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

