import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  String selectedGender = '';
  double age = 12;
  double height = 5.0; // Set default height to 5 feet
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
                    _buildGenderOption(context, 'male'),
                    _buildGenderOption(context, 'female'),
                  ],
                ),
                SizedBox(height: 3.h),
                _buildSlider('Age', 12, 80, age, (value) {
                  setState(() {
                    age = value;
                  });
                }),
                SizedBox(height: 3.h),
                _buildHeightSlider(),
                SizedBox(height: 3.h),
                _buildSlider('Weight', 50, 300, weight, (value) {
                  setState(() {
                    weight = value;
                  });
                }),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final provider = Provider.of<BasicInfoProvider>(context, listen: false);
            await provider.updateBasicInfo(selectedGender, age, height, weight);
            Get.toNamed(AppRoutes.permission);
          },
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          child: const Icon(Icons.arrow_forward, color: AppColors.white),
        ),
      );
    });
  }

  Widget _buildGenderOption(BuildContext context, String gender) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = gender;
            });
          },
          child: Container(
            height: 16.h,
            width: 37.w,
            decoration: BoxDecoration(
              color: selectedGender == gender ? AppColors.grey : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.grey, width: 2),
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Image.asset(
                      gender == 'male' ? AppImages.male : AppImages.female,
                    ),
                  ),
                ),
                if (selectedGender == gender)
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
          gender == 'male' ? "Male" : "Female",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  Widget _buildSlider(String label, double min, double max, double value, Function(double) onChanged, {int? divisions}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.grey,
            inactiveTrackColor: AppColors.grey,
            thumbColor: AppColors.primary,
            valueIndicatorColor: Colors.black,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions ?? (max - min).toInt(),
            label: value.toStringAsFixed(1),
            onChanged: (double newValue) {
              onChanged(newValue);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                min.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                max.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeightSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Height',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColors.grey,
            inactiveTrackColor: AppColors.grey,
            thumbColor: AppColors.primary,
            valueIndicatorColor: Colors.black,
          ),
          child: Slider(
            value: height,
            min: 4,
            max: 7,
            divisions: (7 - 4) * 12, // 12 divisions per foot for inches
            label: _formatHeight(height),
            onChanged: (double newValue) {
              setState(() {
                height = newValue;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '4\'0"',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                '7\'0"',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatHeight(double value) {
    int feet = value.floor();
    int inches = ((value - feet) * 12).round();
    return '${feet}\'${inches}"';
  }
}
