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
    for (var range in scoreRanges) {
      if (value >= range[0] && value <= range[1]) {
        return _calculateScoreForRange(value, range);
      }
    }
    if (value < scoreRanges.first[0]) {
      return scoreRanges.first[2];
    }
    return scoreRanges.last[3];
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

  double getPercentage() {
    double score = calculateScore();
    return score.clamp(0, 100);
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
  double bmi = 24.9;            // Within the 18.5 - 24.9 range
  double energyBurn = 3500.0;   // Within the 2000 - 3500 range
  double heartRate = 80.0;      // Within the 40 - 80 bpm range
  double respiration = 20.0;    // Within the 12 - 20 breaths/min range
  double screenTime = 2;        // Within the 1 - 2 hours range
  double sleep = 8.0;           // Within the 6 - 8 hours range
  double steps = 15000.0;       // Within the 10,000 - 15,000 steps range
  double sunlight = 8.0;        // Within the 1 - 8 hours range

  final List<HealthDataType> types = [
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
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
          types,
        );

        setState(() {
          for (var data in healthData) {
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
          }
          sunlight = 8.0; // Placeholder value for sunlight
        });
      } catch (e) {
        print("Error fetching health data: $e");
      }
    } else {
      print("Authorization not granted");
    }
  }

  double _convertToDouble(Object value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      return 0.0;
    }
  }

  double calculateElixirScore() {
    List<HealthMetric> metrics = [
      HealthMetric("BMI", bmi, 5, [
        [10, 18.5, 0, 60],
        [18.5, 24.9, 60, 100],
        [24.9, 30, 100, 60],
        [30, 50, 60, 0],
      ]),
      HealthMetric("Energy Burn", energyBurn, 15, [
        [1000, 2000, 0, 60],
        [2000, 3500, 60, 100],
        [3500, 5000, 100, 60],
        [5000, 8000, 60, 0],
      ]),
      HealthMetric("Heart Rate", heartRate, 10, [
        [0, 40, 0, 100],
        [40, 80, 100, 100],
        [80, 100, 100, 60],
        [100, 140, 60, 0],
      ]),
      HealthMetric("Respiration", respiration, 5, [
        [8, 12, 0, 60],
        [12, 20, 60, 100],
        [20, 25, 100, 60],
        [25, 30, 60, 0],
      ]),
      HealthMetric("Screen Time", screenTime, 15, [
        [0, 1, 0, 80],
        [1, 2, 80, 100],
        [2, 4, 100, 20],
        [4, 16, 20, 0],
      ]),
      HealthMetric("Sleep", sleep, 20, [
        [4, 6, 0, 60],
        [6, 8, 60, 100],
        [8, 10, 100, 60],
        [10, 12, 60, 0],
      ]),
      HealthMetric("Steps", steps, 10, [
        [0, 5000, 0, 60],
        [5000, 10000, 60, 100],
        [10000, 15000, 100, 100],
        [15000, 30000, 100, 100],
      ]),
      HealthMetric("Sunlight", sunlight, 10, [
        [0, 1, 0, 100],
        [1, 4, 100, 100],
        [4, 6, 100, 100],
        [6, 8, 100, 100],
      ]),
    ];

    double totalWeightedScore = 0.0;
    double totalWeight = 0.0;

    for (var metric in metrics) {
      double score = metric.weightedScore();
      totalWeightedScore += score;
      totalWeight += metric.weight;
    }

    // Normalize the score by ensuring totalWeight is 100
    if (totalWeight > 0) {
      return (totalWeightedScore / totalWeight) * 100;  // Convert to percentage
    } else {
      return 0.0;
    }
  }

  void updateMetricValues(double newBmi, double newEnergyBurn, double newHeartRate, double newRespiration, double newScreenTime, double newSleep, double newSteps, double newSunlight) {
    setState(() {
      bmi = newBmi;
      energyBurn = newEnergyBurn;
      heartRate = newHeartRate;
      respiration = newRespiration;
      screenTime = newScreenTime;
      sleep = newSleep;
      steps = newSteps;
      sunlight = newSunlight;
    });
  }

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3)
      return AppColors.red;
    else if (percentage <= 66.6)
      return AppColors.green;
    else
      return AppColors.primary;
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
                        fetchHealthData();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                buildMetricSection("Diet 🥣️", "BMI", bmi),
                SizedBox(height: 2.h),
                buildMetricSection("Energy 🔥️", "Energy Burn", energyBurn),
                SizedBox(height: 2.h),
                buildMetricSection("Heart❤️", "Heart Rate", heartRate),
                SizedBox(height: 2.h),
                buildMetricSection("Respiration 🫁️", "Respiration", respiration),
                SizedBox(height: 2.h),
                buildMetricSection("Screen Time 📱️", "Screen Time", screenTime),
                SizedBox(height: 2.h),
                buildMetricSection("Sleep 🛏️️", "Sleep", sleep),
                SizedBox(height: 2.h),
                buildMetricSection("Steps 🚶🏻️", "Steps", steps),
                SizedBox(height: 2.h),
                buildMetricSection("Sunlight ☀️️", "Sunlight", sunlight),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildMetricSection(String title, String metricName, double value) {
    // Define all metrics with their respective scoring ranges
    List<HealthMetric> metrics = [
      HealthMetric("BMI", bmi, 50, [
        [10, 18.5, 0, 60],
        [18.5, 24.9, 60, 100],
        [24.9, 30, 100, 60],
        [30, 50, 60, 0],
      ]),
      HealthMetric("Energy Burn", energyBurn, 15, [
        [1000, 2000, 0, 60],
        [2000, 3500, 60, 100],
        [3500, 5000, 100, 60],
        [5000, 8000, 60, 0],
      ]),
      HealthMetric("Heart Rate", heartRate, 10, [
        [0, 40, 0, 100],
        [40, 80, 100, 100],
        [80, 100, 100, 60],
        [100, 140, 60, 0],
      ]),
      HealthMetric("Respiration", respiration, 5, [
        [8, 12, 0, 60],
        [12, 20, 60, 100],
        [20, 25, 100, 60],
        [25, 30, 60, 0],
      ]),
      HealthMetric("Screen Time", screenTime, 15, [
        [0, 1, 0, 80],
        [1, 2, 80, 100],
        [2, 4, 100, 20],
        [4, 16, 20, 0],
      ]),
      HealthMetric("Sleep", sleep, 20, [
        [4, 6, 0, 60],
        [6, 8, 60, 100],
        [8, 10, 100, 60],
        [10, 12, 60, 0],
      ]),
      HealthMetric("Steps", steps, 10, [
        [0, 5000, 0, 60],
        [5000, 10000, 60, 100],
        [10000, 15000, 100, 100],
        [15000, 30000, 100, 100],
      ]),
      HealthMetric("Sunlight", sunlight, 10, [
        [0, 1, 0, 100],
        [1, 4, 100, 100],
        [4, 6, 100, 100],
        [6, 8, 100, 100],
      ]),
    ];

    // Find the metric by name
    HealthMetric? metric =
        metrics.firstWhere((m) => m.name == metricName, orElse: () => HealthMetric(metricName, value, 0, []));

    double percentage = metric.getPercentage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Percentage
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
        // Progress Bar
        SizedBox(
          width: 75.w,
          child: Row(
            children: List.generate(3, (index) {
              // Each block represents roughly 33.3% of the bar
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
}
