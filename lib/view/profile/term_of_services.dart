import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TermsAndServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 5.h,
                              width: 10.w,
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
                 
        title: Text(
          'ElixirScore Terms of Service',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Updated: 08/16/2024',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 16),
              Text(
                'Welcome to the ElixirScore App, a health and wellness platform designed to provide personalized health insights and recommendations. By accessing or using the ElixirScore App, you agree to comply with and be bound by the following Terms of Service ("Terms"). Please read these Terms carefully before using the App.',
              ),
              SizedBox(height: 16),
              ...buildSection('1. Acceptance of Terms', [
                'By accessing, downloading, or using the ElixirScore App, you agree to these Terms and any applicable laws and regulations. If you do not agree with these Terms, you are prohibited from using the App.'
              ]),
              ...buildSection('2. Eligibility', [
                'The ElixirScore App is intended for users who are at least 12 years old. If you are under 18, you may use the App only with the consent and supervision of a parent or legal guardian. By using the App, you represent and warrant that you meet this eligibility requirement.'
              ]),
              ...buildSection('3. Account Registration', [
                'To access certain features of the ElixirScore App, you may be required to create an account. You agree to:',
                'Provide accurate, current, and complete information during the registration process.',
                'Maintain the security of your password and accept all risks of unauthorized access to your account.',
                'Notify us immediately of any breach of security or unauthorized use of your account.'
              ]),
              ...buildSection('4. Privacy Policy', [
                'Your privacy is important to us. Please review our Privacy Policy, which explains how we collect, use, and protect your personal information. By using the ElixirScore App, you agree to the collection and use of information as described in the Privacy Policy.'
              ]),
              ...buildSection('5. User Conduct', [
                'You agree not to:',
                'Use the App in any way that violates any applicable federal, state, local, or international law or regulation.',
                'Engage in any activity that interferes with or disrupts the App\'s functionality.',
                'Attempt to gain unauthorized access to any part of the App, other users\' accounts, or the App\'s underlying technology.'
              ]),
              ...buildSection('6. Health Information Disclaimer', [
                'The ElixirScore App provides health-related information and recommendations based on user data and algorithms. However, the App is not intended to replace professional medical advice, diagnosis, or treatment. Always seek the advice of a qualified healthcare provider with any questions you may have regarding a medical condition. The information provided by the App should not be relied upon as a substitute for professional medical advice.'
              ]),
              ...buildSection('7. Intellectual Property', [
                'All content, features, and functionality of the ElixirScore App, including but not limited to text, graphics, logos, and software, are the exclusive property of Elixir and are protected by copyright, trademark, and other intellectual property laws. You may not reproduce, distribute, modify, or create derivative works from any content of the App without our prior written consent.'
              ]),
              ...buildSection('8. License to Use the App', [
                'Elixir grants you a limited, non-exclusive, non-transferable, revocable license to use the ElixirScore App for your personal, non-commercial use. You may not use the App for any commercial purposes without our prior written consent.'
              ]),
              ...buildSection('9. Subscriptions and Payments', [
                'Certain features of the ElixirScore App may require a subscription. By subscribing, you agree to pay the applicable subscription fees and any associated taxes. All payments are non-refundable. Subscription fees may be subject to change, and we will notify you of any changes in advance.'
              ]),
              ...buildSection('10. Termination', [
                'We reserve the right to terminate or suspend your access to the ElixirScore App at our sole discretion, without notice, for any reason, including but not limited to a violation of these Terms. Upon termination, all rights granted to you under these Terms will cease immediately.'
              ]),
              ...buildSection('11. Limitation of Liability', [
                'To the fullest extent permitted by law, Elixir shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including but not limited to loss of profits, data, or use, arising out of or in connection with your use of the ElixirScore App.'
              ]),
              ...buildSection('12. Indemnification', [
                'You agree to indemnify, defend, and hold harmless Elixir and its officers, directors, employees, and agents from and against any and all claims, liabilities, damages, losses, and expenses, including reasonable attorneys\' fees, arising out of or in any way connected with your access to or use of the ElixirScore App.'
              ]),
              ...buildSection('13. Governing Law', [
                'These Terms shall be governed by and construed in accordance with the federal laws of the United States, without regard to its conflict of law provisions. You agree to submit to the personal jurisdiction of the courts located in the United States for any actions related to these Terms.'
              ]),
              ...buildSection('14. Changes to Terms', [
                'We may modify these Terms at any time by posting the updated Terms on the ElixirScore App. Your continued use of the App after any such changes constitutes your acceptance of the new Terms. We encourage you to review these Terms periodically for any updates.'
              ]),
              ...buildSection('15. Contact Information', [
                'If you have any questions about these Terms, please contact us at info@elixirscore.com.'
              ]),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildSection(String title, List<String> texts) {
    return [
      Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      ...texts.map((text) => Text(text)).toList(),
      SizedBox(height: 16),
    ];
  }
}
