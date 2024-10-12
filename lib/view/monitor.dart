import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsageMonitor extends StatefulWidget {
  const UsageMonitor({super.key});

  @override
  _UsageMonitorState createState() => _UsageMonitorState();
}

class _UsageMonitorState extends State<UsageMonitor> {
  static const platform = MethodChannel('com.elixir.elixirscore/deviceActivity');
  String _usageTime = '0 minutes';

  @override
  void initState() {
    super.initState();
    // Optionally, set up a listener for real-time updates using EventChannel
  }

  Future<void> _startMonitoring() async {
    try {
      final result = await platform.invokeMethod('startMonitoring');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to start monitoring: '${e.message}'.");
    }
  }

  Future<void> _getUsageData() async {
    try {
      final String usage = await platform.invokeMethod('getUsageData');
      setState(() {
        _usageTime = usage;
      });
    } on PlatformException catch (e) {
      print("Failed to get usage data: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('App Usage Monitor'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Usage: $_usageTime',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startMonitoring,
                child: const Text('Start Monitoring'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _getUsageData,
                child: const Text('Get Usage Data'),
              ),
            ],
          ),
        ));
  }
}
