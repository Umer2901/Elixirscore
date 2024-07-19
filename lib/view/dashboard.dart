import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/fonts.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Get.toNamed(AppRoutes.profile);
          }, icon: const Icon(Icons.person_2_outlined)),
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
                        style: Theme.of(context).textTheme.displaySmall ?.copyWith(
                          fontFamily: AppFont.nexaBold,
                          fontSize: 30.sp
                        )
                      ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: SemicircularIndicator(
                    strokeWidth: 10.sp,
                     color: AppColors.primary,
                      bottomPadding: 0,
                      child: Text(
                          '75',
                          style: Theme.of(context).textTheme.displaySmall ?.copyWith(
                            fontFamily: AppFont.nexaBold,
                            fontSize: 45.sp
                          )
                        ),
                    ),
                ),
                  SizedBox(
                  height: 2.h,
                ),
                  Padding(
                    padding: EdgeInsets.only(left: 29.sp,right: 35.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Unhealthy',
                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                            fontFamily: AppFont.nexaBold,
                           color: AppColors.grey
                          )
                        ),
                         Text(
                          'Healthy',
                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                            fontFamily: AppFont.nexaBold,
                           color: AppColors.primary
                          )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                  height: 2.h,
                ),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                                  'Scoring Factors',
                                  style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                  )
                           ),
                           Text(
                                  'Learn more',
                                  style: Theme.of(context).textTheme.bodySmall ?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold
                                  )
                           ),
                         ],
                       ),
                       CustomButton(
                        height: 5.h,
                        width: 30.w,
                        label: "Sync", onPressed: (){})
                     ],
                   ),
                     SizedBox(
                  height: 3.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Diet 🥣️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '96%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                               color: index < 3 ? AppColors.primary : AppColors.grey,
                                                          ),
                                                          height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Energy 🔥️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '71%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 2 ? AppColors.green : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Heart ❤️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '18%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 1 ? AppColors.red : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Respiration 🫁️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '25%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 1 ? AppColors.red : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Screen Time 📱️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '75%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 2 ? AppColors.green : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Sleep 🛏️️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '55%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 1 ? AppColors.red : AppColors.grey,
                                                          ),
                                                            height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Steps 🚶🏻️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '100%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 3 ? AppColors.primary : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
           Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                                      'Sunlight ☀️️',
                                      style: Theme.of(context).textTheme.headlineSmall ?.copyWith(
                                      )),
                                      Row(
                                        children: [
                                          Text(
                                          '98%',
                                          style: Theme.of(context).textTheme.bodyLarge ?.copyWith(
                                          )),
                                          const Icon(Icons. keyboard_arrow_down_rounded,color: AppColors.primary,)
                                        ],
                                      ),
                                      
                      ],
                    ),  SizedBox(
                  height: 1.5.h,
                ),
                                  SizedBox(
                                    width: 75.w,
                                    child: Row(
                                                    children: List.generate(3, (index) {
                                                      return Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(25),
                                                              color: index < 3 ? AppColors.primary : AppColors.grey,
                                                          ),
                                                           height: 5.sp,
                                                          margin: EdgeInsets.symmetric(horizontal: 1.sp),
                                                        
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                  ),
                  ],
                ),
                       SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      );

    });
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_application_elixirscore/constants/colors.dart';
// import 'package:flutter_application_elixirscore/constants/fonts.dart';
// import 'package:flutter_application_elixirscore/routes/app_routes.dart';
// import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'package:semicircle_indicator/semicircle_indicator.dart';

// class HealthMetric {
//   final String name;
//   final double value;
//   final double weight;
//   final double rangeMin;
//   final double rangeMax;

//   HealthMetric(this.name, this.value, this.weight, this.rangeMin, this.rangeMax);

//   double calculateScore() {
//     if (name == "Diet" || name == "Energy Burn" || name == "Steps" || name == "Sunlight") {
//       // Higher is better
//       if (value > rangeMax) {
//         return 100 - 100 * ((value - rangeMax) / (value - rangeMax + rangeMax - rangeMin)).clamp(0, 100);
//       } else if (value < rangeMin) {
//         return 100 - 100 * ((rangeMin - value) / (rangeMin - rangeMax)).clamp(0, 100);
//       } else {
//         return 100;
//       }
//     } else {
//       // Lower is better
//       if (value < rangeMin) {
//         return 100 - 100 * ((rangeMin - value) / (rangeMin - rangeMax)).clamp(0, 100);
//       } else if (value > rangeMax) {
//         return 100 - 100 * ((value - rangeMax) / (value - rangeMax + rangeMax - rangeMin)).clamp(0, 100);
//       } else {
//         return 100;
//       }
//     }
//   }

//   double weightedScore() {
//     return (calculateScore() * weight) / 100;
//   }
// }

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   // Define initial values for metrics
//   double bmi = 1700.0;
//   double diet = 20000;
//   double energyBurn = 2040;
//   double heartRate = 690;
//   double respiration = 22.5;
//   double screenTime = 360;
//   double sleep = 390;
//   double steps = 655;
//   double sunlight = 50;

//   // Function to calculate Elixir Score
//   double calculateElixirScore() {
//     List<HealthMetric> metrics = [
//       HealthMetric("BMI", bmi, 50, 18.5, 24.9),
//       HealthMetric("Diet", diet, 10, 2000, 3000),
//       HealthMetric("Energy Burn", energyBurn, 15, 200, 400),
//       HealthMetric("Heart", heartRate, 10, 50, 80),
//       HealthMetric("Respiration", respiration, 5, 12, 25),
//       HealthMetric("Screen Time", screenTime, 15, 60, 120),
//       HealthMetric("Sleep", sleep, 20, 420, 540),
//       HealthMetric("Steps", steps, 10, 7000, 10000),
//       HealthMetric("Sunlight", sunlight, 10, 30, 90),
//     ];

//     double totalWeightedScore = metrics.map((m) => m.weightedScore()).reduce((a, b) => a + b);
//     double totalWeight = metrics.map((m) => m.weight).reduce((a, b) => a + b);
//     return (totalWeightedScore / totalWeight) * 100;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double elixirScore = calculateElixirScore();

//     return Sizer(builder: (context, orientation, deviceType) {
//       return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Get.toNamed(AppRoutes.profile);
//             },
//             icon: const Icon(Icons.person_2_outlined),
//           ),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(Icons.comment),
//               tooltip: 'Comment Icon',
//               onPressed: () {},
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(8.sp),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Text(
//                     'ElixirScore',
//                     style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                       fontFamily: AppFont.nexaBold,
//                       fontSize: 30.sp,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Center(
//                   child: SemicircularIndicator(
//                     strokeWidth: 10.sp,
//                     color: AppColors.primary,
//                     bottomPadding: 0,
//                     child: Text(
//                       elixirScore.toStringAsFixed(1),
//                       style: Theme.of(context).textTheme.displaySmall?.copyWith(
//                         fontFamily: AppFont.nexaBold,
//                         fontSize: 45.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Padding(
//                   padding: EdgeInsets.only(left: 29.sp, right: 35.sp),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Unhealthy',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           fontFamily: AppFont.nexaBold,
//                           color: AppColors.grey,
//                         ),
//                       ),
//                       Text(
//                         'Healthy',
//                         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                           fontFamily: AppFont.nexaBold,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 2.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Scoring Factors',
//                           style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
//                         ),
//                         Text(
//                           'Learn more',
//                           style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     CustomButton(
//                       height: 5.h,
//                       width: 30.w,
//                       label: "Sync",
//                       onPressed: () {
//                         setState(() {
//                           // Update metrics values and recalculate Elixir Score
//                           // For demonstration purposes, these values are static
//                           // Replace with actual dynamic updates
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 3.h),
//                 buildMetricSection('Diet 🥣️', diet, 96, AppColors.primary, 3, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Energy 🔥️', energyBurn, 71, AppColors.green, 2, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Heart ❤️', heartRate, 18, AppColors.red, 1, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Respiration 🫁️', respiration, 25, AppColors.red, 1, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Screen Time 📱️', screenTime, 75, AppColors.green, 2, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Sleep 🛏️️', sleep, 55, AppColors.red, 1, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Steps 🚶🏻️', steps, 100, AppColors.primary, 3, AppColors.grey),
//                 SizedBox(height: 2.h),
//                 buildMetricSection('Sunlight ☀️️', sunlight, 98, AppColors.primary, 3, AppColors.grey),
//                 SizedBox(height: 2.h),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   Widget buildMetricSection(String title, double value, int percentage, Color barColor, int colorIndex, Color defaultColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               title,
//               style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
//             ),
//             Row(
//               children: [
//                 Text(
//                   '$percentage%',
//                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
//                 ),
//                 const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
//               ],
//             ),
//           ],
//         ),
//         SizedBox(height: 1.5.h),
//         SizedBox(
//           width: 75.w,
//           child: Row(
//             children: List.generate(3, (index) {
//               return Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: index < colorIndex ? barColor : defaultColor,
//                   ),
//                   height: 5.sp,
//                   margin: EdgeInsets.symmetric(horizontal: 1.sp),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }
