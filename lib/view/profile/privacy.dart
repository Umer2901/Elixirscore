import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

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
                 
        title: const Text(
          'ElixirScore Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Last Updated: 08/16/2024',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 16),
              const Text(
                'Elixir ("we," "us," or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use the ElixirScore App ("App"). Please read this Privacy Policy carefully. By using the ElixirScore App, you agree to the collection and use of your information as described in this policy. If you do not agree with the terms of this Privacy Policy, please do not use the App.',
              ),
              const SizedBox(height: 16),
              ...buildSection('1. Information We Collect', [
                'Personal Information:',
                'When you register for the ElixirScore App, we may collect personal information such as your name, email address, date of birth, and any other information you provide during registration.',
                'Health Information:',
                'We may collect health-related information you provide to us through the App, such as data from wearable devices, medical records, health metrics, exercise data, dietary information, and other health-related activities.',
                'Device and Usage Information:',
                'We collect information about your device, including the device\'s IP address, operating system, device identifiers, and browser type.',
                'We collect information about how you use the App, including the features you access, the time spent on the App, and other usage statistics.',
                'Location Information:',
                'With your permission, we may collect and use location information from your device to provide location-based services, such as identifying local healthcare providers or offering location-based recommendations.'
              ]),
              ...buildSection('2. How We Use Your Information', [
                'We use the information we collect for various purposes, including to:',
                'Provide and personalize the App\'s services and features to you.',
                'Monitor and analyze usage and trends to improve the App and your experience.',
                'Provide personalized health recommendations and insights based on your data.',
                'Communicate with you, including sending you updates, security alerts, and support messages.',
                'Ensure the security and integrity of the App.',
                'Comply with legal obligations and protect the rights and safety of Elixir, our users, and others.'
              ]),
              ...buildSection('3. Data Sharing and Transfers', [
                'No Data Transfers:',
                'Elixir does not sell, trade, or transfer your personal information to outside parties. Your data is stored securely and is used solely for the purposes outlined in this Privacy Policy.',
                'Service Providers:',
                'Elixir does not share your personal information with third-party service providers. All data processing is handled internally by Elixir.',
                'Legal Compliance:',
                'We may disclose your information only to comply with legal obligations, respond to legal requests, or protect our legal rights, property, and safety or that of others.'
              ]),
              ...buildSection('4. Data Security', [
                'We implement appropriate technical and organizational measures to protect your information from unauthorized access, use, disclosure, or destruction. However, please be aware that no security measures are perfect or impenetrable, and we cannot guarantee the absolute security of your information.'
              ]),
              ...buildSection('5. Data Retention', [
                'We will retain your personal information only for as long as necessary to fulfill the purposes for which it was collected, comply with legal obligations, resolve disputes, and enforce our agreements. When we no longer need your personal information, we will delete or anonymize it.'
              ]),
              ...buildSection('6. Your Privacy Rights', [
                'Depending on your location, you may have certain rights regarding your personal information, including the right to:',
                'Access, correct, or delete your personal information.',
                'Withdraw consent to processing where consent is required.',
                'Object to or restrict processing of your personal information.',
                'Request the transfer of your personal information to another party.',
                'Lodge a complaint with a data protection authority.',
                'To exercise your rights, please contact us at info@elixirscore.com.'
              ]),
              ...buildSection('7. Children’s Privacy', [
                'The ElixirScore App is not intended for use by children under the age of 12. We do not knowingly collect personal information from children under 12. If we become aware that we have collected personal information from a child under 12 without verification of parental consent, we will delete that information as quickly as possible. If you believe we might have any information from or about a child under 12, please contact us.'
              ]),
              ...buildSection('8. Changes to This Privacy Policy', [
                'We may update this Privacy Policy from time to time. If we make material changes to how we treat your personal information, we will notify you by email and/or through a notice in the App. We encourage you to review this Privacy Policy periodically for any updates.'
              ]),
              ...buildSection('9. Contact Us', [
                'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:',
                'Elixir',
                'info@elixirscore.com'
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
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      ...texts.map((text) => Text(text)),
      const SizedBox(height: 16),
    ];
  }
}
