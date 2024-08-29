import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/fonts.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:health/health.dart';

class HealthMetric {
  final String name;
  final double value;
  final double weight;
  final List<List<double>> scoreRanges;

  HealthMetric(this.name, this.value, this.weight, this.scoreRanges);

  double calculateScore() {
    double score = 0.0;

    for (var range in scoreRanges) {
      if (value >= range[0] && value <= range[1]) {
        score = _calculateScoreForRange(value, range);
        break;
      }
    }

    return score;
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

  double weightedScore() {
    return (calculateScore() * weight) / 100;
  }
}


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double bmi = 10000.0;
  double diet = 2000;
  double energyBurn = 200;
  double heartRate = 0;
  double respiration = 22.5;
  double screenTime = 360;
  double sleep = 200;
  double steps = 0;
  double sunlight = 0;

  // Define the list of health data types
  List<HealthDataType> types = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_IN_BED,
  ];

  @override
  void initState() {
    super.initState();
    fetchHealthData();
  }

  Future<void> fetchHealthData() async {
    final health = HealthFactory();

    bool accessWasGranted = await health.requestAuthorization(types);

    if (accessWasGranted) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(Duration(days: 1)),
          DateTime.now(),
          types,
        );

        for (var data in healthData) {
          setState(() {
            switch (data.type) {
              case HealthDataType.BODY_MASS_INDEX:
                bmi = _convertToDouble(data.value);
                break;
              case HealthDataType.ACTIVE_ENERGY_BURNED:
                energyBurn = _convertToDouble(data.value);
                break;
              case HealthDataType.HEART_RATE:
                heartRate = _convertToDouble(data.value);
                break;
              case HealthDataType.RESTING_HEART_RATE:
                respiration = _convertToDouble(data.value);
                break;
              case HealthDataType.STEPS:
                steps = _convertToDouble(data.value);
                break;
              case HealthDataType.SLEEP_IN_BED:
                sleep = _convertToDouble(data.value);
                break;
              default:
                break;
            }
          });
        }
      } catch (e) {
        print("Error fetching health data: $e");
      }
    } else {
      print("Authorization not granted");
    }
  }

  // Helper method to safely convert to double
  double _convertToDouble(Object value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0; // Default value in case of unsupported type
    }
  }

  double calculateElixirScore() {
    List<HealthMetric> metrics = [
      HealthMetric("BMI", bmi, 50, [
        [0, 18.5, 0, 60],
        [18.5, 24.9, 60, 100],
        [24.9, 30, 100, 60],
        [30, 50, 60, 0],
      ]),
      HealthMetric("Diet", diet, 10, [
        [0, 2000, 0, 60],
        [2000, 3000, 60, 100],
        [3000, 4000, 100, 60],
        [4000, 5000, 60, 0],
      ]),
      HealthMetric("Energy Burn", energyBurn, 15, [
        [0, 200, 0, 60],
        [200, 400, 60, 100],
        [400, 600, 100, 60],
        [600, 800, 60, 0],
      ]),
      HealthMetric("Heart Rate", heartRate, 10, [
        [0, 50, 0, 60],
        [50, 80, 60, 100],
        [80, 100, 100, 60],
        [100, 150, 60, 0],
      ]),
      HealthMetric("Respiration", respiration, 5, [
        [0, 12, 0, 60],
        [12, 25, 60, 100],
        [25, 35, 100, 60],
        [35, 45, 60, 0],
      ]),
      HealthMetric("Screen Time", screenTime, 15, [
        [0, 60, 0, 60],
        [60, 120, 60, 100],
        [120, 180, 100, 60],
        [180, 240, 60, 0],
      ]),
      HealthMetric("Sleep", sleep, 20, [
        [0, 420, 0, 60],
        [420, 540, 60, 100],
        [540, 660, 100, 60],
        [660, 800, 60, 0],
      ]),
      HealthMetric("Steps", steps, 10, [
        [0, 7000, 0, 60],
        [7000, 10000, 60, 100],
        [10000, 13000, 100, 60],
        [13000, 20000, 60, 0],
      ]),
      HealthMetric("Sunlight", sunlight, 10, [
        [0, 30, 0, 60],
        [30, 60, 60, 100],
        [60, 90, 100, 60],
        [90, 120, 60, 0],
      ]),
    ];

    double totalWeightedScore = metrics.map((m) => m.weightedScore()).reduce((a, b) => a + b);
    double totalWeight = metrics.map((m) => m.weight).reduce((a, b) => a + b);
    return (totalWeightedScore / totalWeight) * 100;
  }

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3) return Colors.red;
    if (percentage >= 33.4 && percentage <= 66.6) return Colors.green;
    return Colors.blue; // For percentages greater than 66.7
  }

  @override
  Widget build(BuildContext context) {
    double elixirScore = calculateElixirScore();

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
                        Text(
                          'Learn more',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                      height: 5.h,
                      width: 30.w,
                      label: "Sync",
                      onPressed: () {
                        setState(() {
                          calculateElixirScore();
                          fetchHealthData();
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                buildMetricSection('Diet 🥣️', diet, (diet / 3000 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Energy 🔥️', energyBurn, (energyBurn / 400 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Heart ❤️', heartRate, (heartRate / 80 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Respiration 🫁️', respiration, (respiration / 25 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Screen Time 📱️', screenTime, (screenTime / 120 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Sleep 🛏️️', sleep, (sleep / 540 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Steps 🚶🏻️', steps, (steps / 10000 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
                buildMetricSection('Sunlight ☀️️', sunlight, (sunlight / 90 * 100).toInt(), AppColors.grey),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildMetricSection(String title, double value, int percentage, Color defaultColor) {
    Color barColor = getColorForScore(percentage.toDouble());

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
                  '$percentage%',
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
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: index < percentage / 33.3 ? barColor : defaultColor,
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
}