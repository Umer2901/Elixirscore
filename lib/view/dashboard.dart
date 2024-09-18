import 'dart:io'; // For platform checks
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
        buildMetricSection(context, "BMI 🥣️", "BMI", provider.bmi, calculateMetricScore(provider.bmi, 5, bmiRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Energy 🔥️", "Energy Burn", provider.energyBurn, calculateMetricScore(provider.energyBurn, 15, energyRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Heart❤️", "Heart Rate", provider.heartRate, calculateMetricScore(provider.heartRate, 10, heartRateRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Respiration 🫁️", "Respiration", provider.respiration, calculateMetricScore(provider.respiration, 5, respirationRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Screen Time 📱️", "Screen Time", provider.screenTime, calculateMetricScore(provider.screenTime, 15, screenTimeRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Sleep 🛏️️", "Sleep", provider.sleep, calculateMetricScore(provider.sleep, 20, sleepRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Steps 🚶🏻️", "Steps", provider.steps, calculateMetricScore(provider.steps, 10, stepsRanges)),
        SizedBox(height: 2.h),
        buildMetricSection(context, "Sunlight ☀️️", "Sunlight", provider.sunlight, calculateMetricScore(provider.sunlight, 10, sunlightRanges)),
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
    double bmiScore = calculateMetricScore(provider.bmi, 5, bmiRanges);
    double energyBurnScore = calculateMetricScore(provider.energyBurn, 15, energyRanges);
    double heartRateScore = calculateMetricScore(provider.heartRate, 10, heartRateRanges);
    double respirationScore = calculateMetricScore(provider.respiration, 5, respirationRanges);
    double screenTimeScore = calculateMetricScore(provider.screenTime, 15, screenTimeRanges);
    double sleepScore = calculateMetricScore(provider.sleep, 20, sleepRanges);
    double stepsScore = calculateMetricScore(provider.steps, 10, stepsRanges);
    double sunlightScore = calculateMetricScore(provider.sunlight, 10, sunlightRanges);

    double totalScore = bmiScore +
        energyBurnScore +
        heartRateScore +
        respirationScore +
        screenTimeScore +
        sleepScore +
        stepsScore +
        sunlightScore;

    return totalScore.clamp(0, 100); // Ensure the score is between 0 and 100
  }

  double calculateMetricScore(double value, double weight, List<List<double>> ranges) {
    for (var range in ranges) {
      if (value >= range[0] && value <= range[1]) {
        return _calculateScoreForRange(value, range) * weight / 100;
      }
    }
    if (value < ranges.first[0]) {
      return ranges.first[2] * weight / 100;
    }
    return ranges.last[3] * weight / 100;
  }

  double _calculateScoreForRange(double value, List<double> range) {
    double minValue = range[0];
    double maxValue = range[1];
    double minScore = range[2];
    double maxScore = range[3];

    if (value <= minValue) return minScore;
    if (value >= maxValue) return maxScore;

    double rangeSize = maxValue - minValue;
    double scoreRangeSize = maxScore - minScore;
    double normalizedValue = (value - minValue) / rangeSize;
    return minScore + normalizedValue * scoreRangeSize;
  }

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3)
      return AppColors.red;
    else if (percentage <= 66.6)
      return AppColors.green;
    else
      return AppColors.primary;
  }

  // Define ranges for each metric
  final List<List<double>> bmiRanges = [
    [10, 18.5, 0, 60],
    [18.5, 24.9, 60, 100],
    [24.9, 30, 100, 60],
    [30, 50, 60, 0],
  ];

  final List<List<double>> energyRanges = [
    [1000, 2000, 0, 60],
    [2000, 3500, 60, 100],
    [3500, 5000, 100, 60],
    [5000, 8000, 60, 0],
  ];

  final List<List<double>> heartRateRanges = [
    [0, 40, 0, 100],
    [40, 80, 100, 100],
    [80, 100, 100, 60],
    [100, 140, 60, 0],
  ];

  final List<List<double>> respirationRanges = [
    [8, 12, 0, 60],
    [12, 20, 60, 100],
    [20, 25, 100, 60],
    [25, 30, 60, 0],
  ];

  final List<List<double>> screenTimeRanges = [
    [0, 1, 0, 80],
    [1, 2, 80, 100],
    [2, 4, 100, 20],
    [4, 16, 20, 0],
  ];

  final List<List<double>> sleepRanges = [
    [4, 6, 0, 60],
    [6, 8, 60, 100],
    [8, 10, 100, 60],
    [10, 12, 60, 0],
  ];

  final List<List<double>> stepsRanges = [
    [0, 5000, 0, 60],
    [5000, 10000, 60, 100],
    [10000, 15000, 100, 100],
    [15000, 30000, 100, 100],
  ];

  final List<List<double>> sunlightRanges = [
    [0, 1, 0, 100],
    [1, 4, 100, 100],
    [4, 6, 100, 100],
    [6, 8, 100, 100],
  ];
}
