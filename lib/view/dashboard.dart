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