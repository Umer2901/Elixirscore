// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  void showCustomPanel(BuildContext context, String heading, String detail) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: AppColors.grey,
              ),
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                controller: controller,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        heading,
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: 18.sp
                        )
                      ),
                      IconButton(onPressed: (){ Navigator.of(context).pop();}, icon: const CircleAvatar(backgroundColor:AppColors.white,child: Icon(Icons.close)))
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    detail,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 2.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        label: "Enable",
                        onPressed: () {
                          // Handle enable action
                          Navigator.of(context).pop();
                        },
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomButton(
                        label: "Cancel",
                        borderColor: AppColors.white,
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.black,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Health Sync',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: 1.h),
              Text(
                "Please give the app all permissions",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              SizedBox(
                height: 6.h,
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                children: [
                   Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Apple Health              ❤️',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18.sp,
                              ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                          height: 6.h,
                          label: "Enable",
                          onPressed: () {
                            showCustomPanel(
                                context, 'Apple Health', 'The Health app gathers health data from your iPhone, iPad, Apple Watch, and apps that you already use, so you can view all your progress in one convenient place. Health automatically counts your steps, walking, and running distances. And, if you have an Apple Watch, it automatically tracks your Activity data.');
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Notification                 🔔',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18.sp,
                              ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                           height: 6.h,
                          label: "Enable",
                          onPressed: () {
                            showCustomPanel(
                                context, 'Notification', 'To help you keep track of your health data over time, Health can alert you to significant changes in types of data like resting heart rate, number of steps, and amount of sleep. Trend lines show you how much these metrics have changed and for how long.');
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          'Screen Time                 📱️',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18.sp,
                              ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomButton(
                           height: 6.h,
                          label: "Enable",
                          onPressed: () {
                            showCustomPanel(
                                context, 'Screen Time', 'Screen time is the amount of time spent using a device with a screen such as a smartphone, computer, television, video game console, or even a tablet. The concept is under significant research with related concepts in digital media use and mental health');
                          },
                        )
                      ],
                    ),
                  ),
                ),
                ],
               ),
             )
            ],
          ),
        ),
            floatingActionButton: FloatingActionButton(
          onPressed: () {
           Get.toNamed(AppRoutes.dashboard);
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward,color: AppColors.white,),
        ),
      );
    });
  }
}
