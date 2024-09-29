import 'dart:io';
import 'dart:math'; // Required for the max and min functions
import 'package:flutter/material.dart';
import 'package:health/health.dart';

class HealthDataProvider extends ChangeNotifier {
  // Health metric variables
  double bmi = 0.0;
  double energyBurn = 0.0;
  double heartRate = 0.0;
  double respiration = 0.0;
  double screenTime = 0.0;
  double sleep = 0.0; // Sleep is stored in hours
  double steps = 0.0;
  double diet = 0.0; // Diet score variable
  double sunlight = 8.0; // Placeholder value for sunlight

  // Individual score variables
  double stepsScore = 0.0;
  double bmiScore = 0.0;
  double dietScore = 0.0;
  double energyScore = 0.0;
  double heartScore = 0.0;
  double respirationScore = 0.0;
  double screenTimeScore = 0.0;
  double sleepScore = 0.0;
  double daylightScore = 0.0;

  bool dataFetched = false;

  // Define the health data types to be collected
  final List<HealthDataType> types = [
    HealthDataType.BODY_MASS_INDEX,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.STEPS,
    HealthDataType.DIETARY_CARBS_CONSUMED, // Diet score
    HealthDataType.RESTING_HEART_RATE,
    HealthDataType.RESPIRATORY_RATE,
    HealthDataType.SLEEP_IN_BED, // Sleep duration
    HealthDataType.BODY_TEMPERATURE, // Proxy for sunlight exposure
  ];

  // Fetch health data from the device
  Future<void> fetchHealthData() async {
    final health = HealthFactory();
    bool accessWasGranted;

    if (Platform.isIOS) {
      // Request authorization for iOS
      accessWasGranted = await health.requestAuthorization(types);
    } else if (Platform.isAndroid) {
      // Request authorization for Android with read permissions
      List<HealthDataAccess> permissions = List.filled(types.length, HealthDataAccess.READ);
      accessWasGranted = await health.requestAuthorization(types, permissions: permissions);
    } else {
      accessWasGranted = false;
    }

    if (accessWasGranted) {
      try {
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 1)),
          DateTime.now(),
          types,
        );

        // Process each health data point and update the state accordingly
        for (var data in healthData) {
          switch (data.type) {
            case HealthDataType.BODY_MASS_INDEX:
              bmi = _convertToDouble(data.value);
              bmiScore = calculateBMIScore(bmi);
              break;
            case HealthDataType.ACTIVE_ENERGY_BURNED:
              energyBurn = _convertToDouble(data.value);
              energyScore = calculateEnergyScore(energyBurn);
              print("Energy Burn: $energyBurn, Energy Score: $energyScore");
              break;
            case HealthDataType.STEPS:
              steps = _convertToDouble(data.value);
              stepsScore = calculateStepsScore(steps);
              print("Steps: $steps, Steps Score: $stepsScore");
              break;
            case HealthDataType.DIETARY_CARBS_CONSUMED:
              diet = _convertToDouble(data.value);
              dietScore = calculateDietScore(diet);
              break;
            case HealthDataType.RESTING_HEART_RATE:
              heartRate = _convertToDouble(data.value);
              heartScore = calculateHeartScore(heartRate);
              break;
            case HealthDataType.RESPIRATORY_RATE:
              respiration = _convertToDouble(data.value);
              respirationScore = calculateRespirationScore(respiration);
              break;
            case HealthDataType.SLEEP_IN_BED:
              sleep = _convertToDouble(data.value) / 60; // Convert minutes to hours
              sleepScore = calculateSleepScore(sleep);
              print("Sleep: $sleep hours, Sleep Score: $sleepScore");
              break;
            case HealthDataType.BODY_TEMPERATURE:
              sunlight = _convertToDouble(data.value); // Using temperature as a proxy for sunlight
              daylightScore = calculateDaylightScore(sunlight);
              break;
            default:
              break;
          }
        }

        // Set data fetched status to true and notify listeners
        dataFetched = true;
        notifyListeners();
      } catch (e) {
        print("Error fetching health data: $e");
      }
    } else {
      print("Authorization not granted");
    }
  }

  // Calculation methods for each health metric
  double calculateBMIScore(double bmi) {
    double lowerBound = 18.5;
    double upperBound = 24.9;
    return min(100, (bmi < lowerBound)
        ? max(0, 100 - 100 * ((lowerBound - bmi) / (upperBound - lowerBound)))
        : (bmi > upperBound)
            ? 100 + 100 * ((bmi - upperBound) / (upperBound - lowerBound))
            : 100);
  }

  double calculateDietScore(double diet) {
    double lowerBound = 1200;
    double upperBound = 1800;
    return min(100, (diet > upperBound)
        ? 100 + 100 * ((diet - upperBound) / (upperBound - lowerBound))
        : (diet < lowerBound)
            ? max(0, 100 * (diet / lowerBound))
            : 100);
  }

  double calculateEnergyScore(double energy) {
    double lowerBound = 1500;
    double upperBound = 3000;
    return min(100, (energy > upperBound)
        ? 100 + 100 * ((energy - upperBound) / (upperBound - lowerBound))
        : (energy < lowerBound)
            ? max(0, 100 * (energy / lowerBound))
            : 100);
  }

  double calculateHeartScore(double heartRate) {
    double lowerBound = 60;
    double upperBound = 80;
    return min(100, (heartRate < lowerBound)
        ? max(0, 100 - 100 * ((lowerBound - heartRate) / (upperBound - lowerBound)))
        : (heartRate > upperBound)
            ? 100 + 100 * ((heartRate - upperBound) / (upperBound - lowerBound))
            : 100);
  }

  double calculateRespirationScore(double respiration) {
    double lowerBound = 12;
    double upperBound = 20;
    return min(100, (respiration < lowerBound)
        ? max(0, 100 - 100 * ((lowerBound - respiration) / (upperBound - lowerBound)))
        : (respiration > upperBound)
            ? 100 + 100 * ((respiration - upperBound) / (upperBound - lowerBound))
            : 100);
  }

  double calculateScreenTimeScore(double screenTime) {
    double lowerBound = 1;
    double upperBound = 2;
    return min(100, (screenTime > upperBound)
        ? max(0, 100 - 100 * ((screenTime - upperBound) / (upperBound - lowerBound)))
        : (screenTime < lowerBound)
            ? 100 + 100 * ((lowerBound - screenTime) / (upperBound - lowerBound))
            : 100);
  }

  double calculateSleepScore(double sleep) {
    double lowerBound = 6; // Minimum recommended hours of sleep
    double upperBound = 8; // Maximum optimal hours of sleep
    return min(100, (sleep < lowerBound)
        ? max(0, 100 * (sleep / lowerBound)) // Proportional score based on hours of sleep
        : (sleep > upperBound)
            ? 100 + 100 * ((sleep - upperBound) / (upperBound - lowerBound))
            : 100);
  }

  double calculateStepsScore(double steps) {
    double lowerBound = 5000;
    double upperBound = 10000;
    return min(100, (steps > upperBound)
        ? 100 + 100 * ((steps - upperBound) / (upperBound - lowerBound))
        : (steps < lowerBound)
            ? max(0, 100 * (steps / lowerBound))
            : 100);
  }

  double calculateDaylightScore(double daylight) {
    double lowerBound = 1;
    double upperBound = 4;
    return min(100, (daylight > upperBound)
        ? 100 + 100 * ((daylight - upperBound) / (upperBound - lowerBound))
        : (daylight < lowerBound)
            ? max(0, 100 * (daylight / lowerBound))
            : 100);
  }

  // Helper method to convert various data types to double
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
