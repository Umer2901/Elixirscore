import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/constants/colors.dart';
import 'package:flutter_application_elixirscore/providers/basic_info_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  void initState() {
    super.initState();
    _loadAccountInfo();
  }

  Future<void> _loadAccountInfo() async {
    final provider = Provider.of<BasicInfoProvider>(context, listen: false);
    await provider.loadBasicInfo();
  }

  @override
  Widget build(BuildContext context) {
    final basicInfoProvider = Provider.of<BasicInfoProvider>(context);

    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          leading:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
             Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.grey, width: 2),
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
        ),
          title: Text(
            'Account Information',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: basicInfoProvider.basicInfo == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    _buildInfoRow('Gender', basicInfoProvider.basicInfo!.selectedGender),
                    _buildInfoRow('Age', basicInfoProvider.basicInfo!.age.toStringAsFixed(2)),
                    _buildInfoRow('Height', basicInfoProvider.basicInfo!.height.toStringAsFixed(2) + ' ft'),
                    _buildInfoRow('Weight', basicInfoProvider.basicInfo!.weight.toStringAsFixed(2) + ' lbs'),
                    _buildInfoRow('Email', basicInfoProvider.basicInfo!.email),
                    _buildInfoRow('Phone Number', basicInfoProvider.basicInfo!.phoneNumber.isEmpty ? 'N/A' : basicInfoProvider.basicInfo!.phoneNumber),
                  ],
                ),
        ),
      );
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
