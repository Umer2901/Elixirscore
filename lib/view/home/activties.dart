import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/constants/fonts.dart';
import 'package:flutter_application_elixirscore/constants/images.dart';
import 'package:flutter_application_elixirscore/providers/health_provider.dart';
import 'package:flutter_application_elixirscore/providers/loading_provider.dart';
import 'package:flutter_application_elixirscore/routes/app_routes.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_buttons.dart';
import 'package:flutter_application_elixirscore/view/widget/custom_ring.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';
import 'package:sizer/sizer.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  double calculateElixirScore(HealthDataProvider provider) {
    double bmiWeightedScore = provider.bmiScore * 0.10;
    double dietWeightedScore = provider.dietScore * 0.15;
    double energyBurnWeightedScore = provider.energyScore * 0.15;
    double heartWeightedScore = provider.heartScore * 0.15;
    double respirationWeightedScore = provider.respirationScore * 0.10;
    double sleepWeightedScore = provider.sleepScore * 0.20;
    double stepsWeightedScore = provider.stepsScore * 0.15;

    double totalWeightedScore = bmiWeightedScore +
        dietWeightedScore +
        energyBurnWeightedScore +
        heartWeightedScore +
        respirationWeightedScore +
        sleepWeightedScore +
        stepsWeightedScore;

    return totalWeightedScore.clamp(0, 100);
  }

  Color getColorForScore(double percentage) {
    if (percentage <= 33.3) {
      return AppColors.red;
    } else if (percentage <= 66.6) {
      return AppColors.green;
    } else {
      return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loadingprovider = Provider.of<LoadingProvider>(context);
    return Consumer<HealthDataProvider>(
      builder: (context, provider, child) {
        double elixirScore = calculateElixirScore(provider);

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 242, 242, 243),
          appBar: AppBar(
            title: Center(
              child: Text(
                'ElixirPT',
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
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.settings),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // SizedBox(height: 2.h),
                  Container(
                  // height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.sp),
                       color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 2.h),
                              SizedBox(
                                height: 10.h,
                                width: 50.w,
                                child: Center(
                                  child: SemicircularIndicator(
                                    progress: elixirScore / 100,
                                    strokeWidth: 8.sp,
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
                                  SizedBox(width: 20.w),
                                  Text(
                                    'Ready',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          fontFamily: AppFont.nexaBold,
                                          color: AppColors.primary,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                            width: 42.w,
                            child: Center(
                              child: FitnessRings(
                                move: 0.7,
                                exercise: 0.5,
                                stand: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
SizedBox(height: 1.h,)  ,               
                  Text(
                    'Activities',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontFamily: AppFont.nexaBold,
                        ),
                  ),
                  SizedBox(height: 1.h,)  ,   
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: AppColors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(AppImages.walk),
                          ),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.only(left: 4.sp),
                          child: CustomButton(
                            height: 5.h,
                            width: 20.w,
                            label: loadingprovider.isLoading ? "Syncing..." : "Start",
                            isLoading: loadingprovider.isLoading,
                            onPressed: () async {
                              loadingprovider.setLoading(true);
                              await provider.fetchHealthData();
                              setState(() {
                                 loadingprovider.setLoading(false);
                              });
                             
                            },
                          ),
                        ),
                        title: Text('Outdoor Walk'),
                        subtitle: Text(
                          '0.57MI',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: 20.sp,
                                color: const Color.fromARGB(255, 125, 238, 1),
                              ),
                        ),
                      ),
                    ),
                  ),
                
SizedBox(
  height: MediaQuery.of(context).size.height * 0.5, 
  child: ListView.builder(
    padding: const EdgeInsets.all(8.0),
    itemCount: 5, 
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 20.sp,
              backgroundColor: AppColors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImages.walk),
              ),
            ),
            trailing: Text(
              "Today>",
              style: TextStyle(fontSize: 14.sp, color: AppColors.grey),
            ),
            title: Text('Outdoor Walk'),
            subtitle: Text(
              '0.57MI',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontSize: 20.sp,
                    color: const Color.fromARGB(255, 125, 238, 1),
                  ),
            ),
          ),
        ),
      );
    },
  ),
)

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
