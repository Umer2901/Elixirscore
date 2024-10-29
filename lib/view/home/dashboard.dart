
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/fonts.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:flutter_application_elixirscore/providers/health_provider.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:health/health.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  static const platform = MethodChannel('com.elixir.elixirscore/deviceActivity'); // MethodChannel for native communication
  String _errorMessage = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    //  _startMonitoring();
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

  // Start screen time monitoring and request permission if needed
  //      Future<void> _startMonitoring() async {
  //   try {
  //     await platform.invokeMethod('startMonitoring');
  //     print("Screen time monitoring started.");
  //     _getUsageData(); // Fetch initial screen time usage data
  //   } on PlatformException catch (e) {
  //     print("Failed to start monitoring: '${e.message}'.");
  //   }
  // }

  // // Get the screen time usage data and update the HealthDataProvider
  // Future<void> _getUsageData() async {
  //   try {
  //     final String usage = await platform.invokeMethod('getUsageData');
  //     print("Retrieved screen time: $usage");

  //     // Assuming the usage data is in minutes, convert to a double value
  //     double screenTime = double.tryParse(usage.split(' ').first) ?? 0.0;

  //     // Update the HealthDataProvider with the screen time value
  //     Provider.of<HealthDataProvider>(context, listen: false).screenTime = screenTime;
  //     Provider.of<HealthDataProvider>(context, listen: false).screenTimeScore =
  //     Provider.of<HealthDataProvider>(context, listen: false).calculateScreenTimeScore(screenTime);

  //     // Notify listeners to update UI or data dependencies
  //     Provider.of<HealthDataProvider>(context, listen: false).notifyListeners();
  //   } on PlatformException catch (e) {
  //     print("Failed to get usage data: '${e.message}'.");
  //   }
  // }
  @override
  Widget build(BuildContext context) {
     final basicInfoProvider = Provider.of<BasicInfoProvider>(context, listen: false);
     final loadingprovider = Provider.of<LoadingProvider>(context);
    return Consumer<HealthDataProvider>(
      builder: (context, provider, child) {
        
        double elixirScore = calculateElixirScore(provider);

        return Sizer(builder: (context, orientation, deviceType) {
          
          return Scaffold(
            appBar: AppBar(
            title: Center(
                      child: Text(
                        'ElixirScore',
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontFamily: AppFont.nexaBold,
                              fontSize: 25.sp,
                            ),
                      ),
                    ),
                    
             scrolledUnderElevation: 0.0,
             forceMaterialTransparency: true,
surfaceTintColor: Colors.transparent,
              
    
              leading: IconButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.profile);
                },
                icon: const Icon(Icons.person_2_outlined),
              ),
              actions: <Widget>[
                 Padding(
  padding: EdgeInsets.only(right: 7.sp), 
  child: IconButton(onPressed: (){}, icon: const Icon(  CupertinoIcons.settings,)),
                 ),
//             Padding(
//   padding: EdgeInsets.only(right: 7.sp), 
//   child: GestureDetector(
//     onTap: () async {
//       await basicInfoProvider.loadBasicInfo();
//       if (basicInfoProvider.basicInfo != null) {
//         Get.toNamed(AppRoutes.chat,arguments:basicInfoProvider.basicInfo!.uid );
//       }
//     },
//     child: Image.asset(
//       'assets/images/logo.png',
//       height: 25.sp,
//     ),
//   ),
// )

        
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                    "Heart Rate",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          fontWeight: FontWeight.bold
                                        ),
                                  ),
                                   Text(
                                    "75bpm",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          color: AppColors.red
                                        ),
                                  ),
                                   Text(
                                    "Temperature",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                           fontWeight: FontWeight.bold
                                        ),
                                  ),
                                   Text(
                                    "37°C",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          color: AppColors.green
                                        ),
                                  ),
                                   Text(
                                    "Oxygen",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                           fontWeight: FontWeight.bold
                                        ),
                                  ),
                                   Text(
                                    "99%",
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          color: const Color.fromARGB(255, 112, 147, 253)
                                        ),
                                  ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                               width: 30.h,
                              child: Center(
                                child: SemicircularIndicator(
                                  progress: elixirScore / 100,
                                  strokeWidth: 7.sp,
                                  color: getColorForScore(elixirScore),
                                  bottomPadding: 0,
                                  child: Text(
                                    elixirScore.toStringAsFixed(1),
                                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          fontSize: 30.sp,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                             SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Recover',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontFamily: AppFont.nexaBold,
                                color: AppColors.grey,
                              ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Text(
                          ' Ready',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontFamily: AppFont.nexaBold,
                                color: AppColors.primary,
                              ),
                        ),
                      ],
                    ),
                           SizedBox(
                            height: 2.h,
                           ),
                           Padding(
                             padding: EdgeInsets.only(left: 4.sp),
                             child: CustomButton(
                               height: 5.h,
                               width: 30.w,
                               label: loadingprovider.isLoading ? "Syncing..." : "Sync", 
                               isLoading: loadingprovider.isLoading, 
                               onPressed: 
                                 () async {
                                      
                                        loadingprovider.setLoading(true);
                             
                                       await provider.fetchHealthData(); 
                             
                                       setState(() {
                                         loadingprovider.setLoading(false);
                                       });
                                     },
                             ),
                           ),

                          ],
                        ),
                        
                      ],
                    ),
                   
                   
                   
                   
                   
                    SizedBox(height: 3.h),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
 buildMetricSection(context, "Heart ❤️", "Heart Rate", provider.heartRate, provider.heartScore),
        SizedBox(
          width: 1.h,
        ),
        buildMetricSection(context, "BMI 🥣️", "BMI", provider.bmi, provider.bmiScore),
        
          ],
        ),
          SizedBox(
           height: 3.h,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
         buildMetricSection(context, "Nutrition 🥗", "Diet", provider.diet, provider.dietScore),
        SizedBox(
          width: 1.h,
        ),
        buildMetricSection(context, "Energy 🔥️", "Energy Burn", provider.energyBurn, provider.energyScore),
        
          ],
        ),
          SizedBox(
           height: 3.h,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              buildMetricSection(context, "Steps 🚶🏻️", "Steps", provider.steps, provider.stepsScore),
   
        SizedBox(
          width: 1.h,
        ),
        buildMetricSection(context, "Sleep 🛏️️", "Sleep", provider.sleep, provider.sleepScore),
          ],
        ),
         
    
        SizedBox(
          height: 3.h,
        ),
       Container(
        width: 55.w,
        child: buildMetricSection(context, "Respiration 🫁️", "Respiration", provider.respiration, provider.respirationScore)),
     //   buildMetricSection(context, "Daylight ☀️️", "Daylight", provider.sunlight, provider.daylightScore),
      ],
    );
  }

  

  Widget buildMetricSection(BuildContext context, String title, String metricName, double value, double percentage) {
    return Container(
      width: 46.w,
      child: Column(
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
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
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
      ),
    );
  }

  double calculateElixirScore(HealthDataProvider provider) {
    // Apply weightages to each metric's score
    double bmiWeightedScore = provider.bmiScore * 0.10; // 10% weightage
    double dietWeightedScore = provider.dietScore * 0.15; // 10% weightage
    double energyBurnWeightedScore = provider.energyScore * 0.15; // 15% weightage
    double heartWeightedScore = provider.heartScore * 0.15; // 15% weightage
    double respirationWeightedScore = provider.respirationScore * 0.10; // 10% weightage
   // double screenTimeWeightedScore = provider.screenTimeScore * 0.10; // 10% weightage cancel
    double sleepWeightedScore = provider.sleepScore * 0.20; // 20% weightage
    double stepsWeightedScore = provider.stepsScore * 0.15; // 15% weightage

    // Calculate total weighted score by summing up all weighted scores
    double totalWeightedScore = bmiWeightedScore +
        dietWeightedScore +
        energyBurnWeightedScore +
        heartWeightedScore +
        respirationWeightedScore +
     //   screenTimeWeightedScore +
        sleepWeightedScore +
        stepsWeightedScore;

    // Cap the total score at 100 if it exceeds that value
    return totalWeightedScore.clamp(0, 100);
  }

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3) {
      return AppColors.red;
    } else if (percentage <= 66.6)
      return AppColors.green;
    else
      return AppColors.primary;
  }

}
