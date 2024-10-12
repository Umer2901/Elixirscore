// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  _ExperienceFormState createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadBasicInfo();
  }

  Future<void> _loadBasicInfo() async {
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context, listen: false);
    await basicInfoProvider.loadBasicInfo();
  }

  Future<void> _submitForm(String uid, String email) async {
    String message = _messageController.text.trim();

    if (message.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        await _firestore.collection('experiences').add({
          'uid': uid,
          'email': email,
          'message': message,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Experience submitted successfully!')),
        );

        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit experience: $e')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out the message field')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
             Get.back();
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
        title:  Center(
          child: Text('Feedback       ',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18.sp)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('info@elixir.com',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                         SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Please share any feedback below ❤️',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 12.sp)),
              ],
            ),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Questions? Comments? Concerns?'),
              maxLines: 5,
            ),
             SizedBox(height: 5.h),
            CustomButton(
              isLoading: isLoading,
              label: "Submit",
              onPressed: () {
                if (!isLoading) {
                  _submitForm(
                    basicInfoProvider.basicInfo?.uid ?? 'Loading...',
                    basicInfoProvider.basicInfo?.email ?? 'Loading...',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
