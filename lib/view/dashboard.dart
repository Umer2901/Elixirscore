import 'dart:io'; // For platform checks
import 'dart:math'; // Import for using max() function
import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/fonts.dart';
import 'package:flutter_application_elixirscore/providers/health_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:health/health.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      // Trigger fetching health data from the provider
      await Provider.of<HealthDataProvider>(context, listen: false).fetchHealthData();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch health data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthDataProvider>(
      builder: (context, provider, child) {
        if (!provider.dataFetched) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator while data is being fetched
        }

        double elixirScore = calculateElixirScore(provider);

        return Sizer(builder: (context, orientation, deviceType) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              surfaceTintColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.profile);
                },
                icon: const Icon(Icons.person_2_outlined),
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.comment),
                  tooltip: 'Comment Icon',
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'ElixirScore',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontFamily: AppFont.nexaBold,
                              fontSize: 30.sp,
                            ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Center(
                      child: SemicircularIndicator(
                        progress: elixirScore / 100,
                        strokeWidth: 10.sp,
                        color: getColorForScore(elixirScore),
                        bottomPadding: 0,
                        child: Text(
                          elixirScore.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontFamily: AppFont.nexaBold,
                                fontSize: 45.sp,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 29.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Unhealthy',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontFamily: AppFont.nexaBold,
                                  color: AppColors.grey,
                                ),
                          ),
                          Text(
                            'Healthy',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontFamily: AppFont.nexaBold,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Scoring Factors',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to more info
                              },
                              child: Text(
                                'Learn more',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        CustomButton(
                          height: 5.h,
                          width: 30.w,
                          label: "Sync",
                          onPressed: () {
                            provider.fetchHealthData(); // Fetch the latest health data
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    buildMetricsSection(context, provider),
                    SizedBox(height: 2.h),
                   
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget buildMetricsSection(BuildContext context, HealthDataProvider provider) {
    return Column(
      children: [
        buildMetricSection(context, "BMI 🥣️", "BMI", provider.bmi, provider.bmiScore),
        buildMetricSection(context, "Diet 🥗", "Diet", provider.diet, provider.dietScore),
        buildMetricSection(context, "Energy 🔥️", "Energy Burn", provider.energyBurn, provider.energyScore),
        buildMetricSection(context, "Heart ❤️", "Heart Rate", provider.heartRate, provider.heartScore),
        buildMetricSection(context, "Respiration 🫁️", "Respiration", provider.respiration, provider.respirationScore),
        buildMetricSection(context, "Screen Time 📱️", "Screen Time", provider.screenTime, provider.screenTimeScore),
        buildMetricSection(context, "Sleep 🛏️️", "Sleep", provider.sleep, provider.sleepScore),
        buildMetricSection(context, "Steps 🚶🏻️", "Steps", provider.steps, provider.stepsScore),
        //buildMetricSection(context, "Daylight ☀️️", "Daylight", provider.sunlight, provider.daylightScore),
      ],
    );
  }

  Widget buildMetricSection(BuildContext context, String title, String metricName, double value, double percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
            ),
            Row(
              children: [
                Text(
                  '${percentage.toInt()}%',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
                ),
                const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
              ],
            ),
          ],
        ),
        SizedBox(height: 1.5.h),
        SizedBox(
          width: 75.w,
          child: Row(
            children: List.generate(3, (index) {
              bool active = percentage > (index * 33.3);
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: active ? getColorForScore(percentage) : AppColors.grey,
                  ),
                  height: 5.sp,
                  margin: EdgeInsets.symmetric(horizontal: 1.sp),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

double calculateElixirScore(HealthDataProvider provider) {
  // Apply weightages to each metric's score
  double bmiWeightedScore = provider.bmiScore * 0.05; // 5% weightage
  double dietWeightedScore = provider.dietScore * 0.10; // 10% weightage
  double energyBurnWeightedScore = provider.energyScore * 0.15; // 15% weightage
  double heartWeightedScore = provider.heartScore * 0.15; // 15% weightage
  double respirationWeightedScore = provider.respirationScore * 0.10; // 10% weightage
  double screenTimeWeightedScore = provider.screenTimeScore * 0.10; // 10% weightage
  double sleepWeightedScore = provider.sleepScore * 0.20; // 20% weightage
  double stepsWeightedScore = provider.stepsScore * 0.15; // 15% weightage

  // Calculate total weighted score by summing up all weighted scores
  double totalWeightedScore = bmiWeightedScore +
      dietWeightedScore +
      energyBurnWeightedScore +
      heartWeightedScore +
      respirationWeightedScore +
      screenTimeWeightedScore +
      sleepWeightedScore +
      stepsWeightedScore;

  // Cap the total score at 100 if it exceeds that value
  return totalWeightedScore.clamp(0, 100);
}

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3)
      return AppColors.red;
    else if (percentage <= 66.6)
      return AppColors.green;
    else
      return AppColors.primary;
  }
}
