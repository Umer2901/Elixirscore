import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}
//done
class _BasicInfoState extends State<BasicInfo> {
  String selectedGender = '';
  double age = 12;
  double height = 4;
  double weight = 50;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  'Give us some basic information',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGender = 'male';
                            });
                          },
                          child: Container(
                            height: 16.h,
                            width: 37.w,
                            decoration: BoxDecoration(
                              color: selectedGender == 'male'
                                  ? AppColors.grey
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.grey, width: 2),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Image.asset(AppImages.male),
                                  ),
                                ),
                                if (selectedGender == 'male')
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 30,
                                      color: AppColors.primary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Male",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedGender = 'female';
                            });
                          },
                          child: Container(
                            height: 16.h,
                            width: 37.w,
                            decoration: BoxDecoration(
                              color: selectedGender == 'female'
                                  ? AppColors.grey
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColors.grey, width: 2),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(25),
                                    child: Image.asset(AppImages.female),
                                  ),
                                ),
                                if (selectedGender == 'female')
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 30,
                                      color: AppColors.primary,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "Female",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  "Age",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImages.male,height: 3.h,width: 10.w,),
                     Image.asset(AppImages.male,height: 5.h,width: 10.w,),
                  ],
                ),
                 SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.grey,
                    inactiveTrackColor: AppColors.grey,
                    thumbColor: AppColors.primary,
                    valueIndicatorColor: Colors.black, 
                  ),
                  child: Slider(
                    // activeColor: AppColors.grey,
                    // thumbColor: AppColors.primary,
                    value: age,
                    min: 12,
                    max: 80,
                    divisions: 68,
                    label: age.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        age = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                            "12",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                       Text(
                            "80",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                    ],
                  ),
                ),
               
                SizedBox(height: 3.h),
                Text(
                  "Height",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AppImages.male,height: 3.h,width: 10.w,),
                     Image.asset(AppImages.male,height: 5.h,width: 10.w,),
                  ],
                ),
                 SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.grey,
                    inactiveTrackColor: AppColors.grey,
                    thumbColor: AppColors.primary,
                    valueIndicatorColor: Colors.black, 
                  ),
                  child: Slider(
                    // activeColor: AppColors.grey,
                    // thumbColor: AppColors.primary,
                    value: height,
                    min: 4,
                    max: 7,
                    divisions: 36,
                    label: "${height.toStringAsFixed(2)} ft",
                    onChanged: (double value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                            "4ft",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                       Text(
                            "7ft",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                    ],
                  ),
                ),
               
                SizedBox(height: 3.h),
                Text(
                  "Weight",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   
                     Image.asset(AppImages.male,height: 4.h,width: 10.w,),
                      Image.asset(AppImages.fat,height: 5.h,width: 10.w,),
                  ],
                ),
               SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.grey,
                    inactiveTrackColor: AppColors.grey,
                    thumbColor: AppColors.primary,
                    valueIndicatorColor: Colors.black, 
                  ),
                  child: Slider(
                    value: weight,
                    min: 50,
                    max: 300,
                    divisions: 250,
                    label: "${weight.round()} lbs",
                    onChanged: (double value) {
                      setState(() {
                        weight = value;
                      });
                    },
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                            "50lbs",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                       Text(
                            "300lbs",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                    ],
                  ),
                ),
              
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           Get.toNamed(AppRoutes.permission);
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward,color: AppColors.white,),
        ),
      );
    });
  }
}
