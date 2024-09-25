import 'package:flutter/material.dart';
import 'package:flutter_application_elixirscore/providers/helper.dart';

class MyApp1 extends StatelessWidget {
final DeviceActivityHelper _deviceActivityHelper = DeviceActivityHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Device Activity Monitor')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _deviceActivityHelper.startMonitoring();
                },
                child: Text('Start Monitoring'),
              ),
              ElevatedButton(
                onPressed: () {
                  _deviceActivityHelper.getUsageData();
                },
                child: Text('Get Usage Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
