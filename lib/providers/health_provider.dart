import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health/health.dart';

class HealthDataProvider extends ChangeNotifier {
  double bmi = 0.0;
  double energyBurn = 0;
  double heartRate = 0;
  double respiration = 0;
  double screenTime = 0;
  double sleep = 0;
  double steps = 0;
  double sunlight = 8.0;

  bool dataFetched = false;

  final List<HealthDataType> types = [
HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.RESPIRATORY_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_IN_BED,
  ];

  Future<void> fetchHealthData() async {
    final health = HealthFactory();
    bool accessWasGranted;

      List<HealthDataType> supportedTypes = [
HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.HEART_RATE,
    HealthDataType.RESPIRATORY_RATE,
    HealthDataType.STEPS,
    HealthDataType.SLEEP_IN_BED,
    ];

    if (Platform.isIOS) {
      supportedTypes.add(HealthDataType.RESTING_HEART_RATE);
    }

    // Request authorization for supported types
    if (Platform.isIOS) {
      accessWasGranted = await health.requestAuthorization(supportedTypes);
    } else if (Platform.isAndroid) {
      List<HealthDataAccess> permissions = List.filled(supportedTypes.length, HealthDataAccess.READ);
      accessWasGranted = await health.requestAuthorization(supportedTypes, permissions: permissions);
    } else {
      accessWasGranted = false;
    }

    if (accessWasGranted) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
          supportedTypes,
        );

        // Update the state with the fetched data
        for (var data in healthData) {
  print('Data type: ${data.type}, value: ${data.value}');  // Debugging
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
    case HealthDataType.RESPIRATORY_RATE:
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
        dataFetched = true;
        notifyListeners(); // Notify listeners after fetching data
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
    } else if (value is NumericHealthValue) {
      return value.numericValue.toDouble();
    } else {
      return 0.0;
    }
  }
}