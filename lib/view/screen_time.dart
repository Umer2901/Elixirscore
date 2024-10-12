import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/providers/helper.dart';

class MyApp1 extends StatelessWidget {
final DeviceActivityHelper _deviceActivityHelper = DeviceActivityHelper();

  MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Device Activity Monitor')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _deviceActivityHelper.startMonitoring();
                },
                child: const Text('Start Monitoring'),
              ),
              ElevatedButton(
                onPressed: () {
                  _deviceActivityHelper.getUsageData();
                },
                child: const Text('Get Usage Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
