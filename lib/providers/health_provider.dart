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

  // Fetch health data from the device using the latest data available
  Future<void> fetchHealthData() async {
    final health = HealthFactory();
    bool accessWasGranted;

    // Request permissions for the specified health data types
    if (Platform.isIOS) {
      accessWasGranted = await health.requestAuthorization(types);
    } else if (Platform.isAndroid) {
      List<HealthDataAccess> permissions = List.filled(types.length, HealthDataAccess.READ);
      accessWasGranted = await health.requestAuthorization(types, permissions: permissions);
    } else {
      accessWasGranted = false;
    }

    if (accessWasGranted) {
      try {
        // Fetch the latest health data without specifying date range
        List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
          DateTime.now().subtract(const Duration(days: 365)), // Start date as far back as possible
          DateTime.now(), // End date as today
          types,
        );

        // Map to store the latest data points for each health data type
        Map<HealthDataType, HealthDataPoint> latestDataPoints = {};

        // Iterate through the health data and keep only the most recent data point for each type
        for (var data in healthData) {
          // If the data type already has a value, compare timestamps and keep the latest one
          if (!latestDataPoints.containsKey(data.type) ||
              data.dateFrom.isAfter(latestDataPoints[data.type]!.dateFrom)) {
            latestDataPoints[data.type] = data;
          }
        }

        // Update health metrics with the most recent data points
        for (var entry in latestDataPoints.entries) {
          switch (entry.key) {
            case HealthDataType.BODY_MASS_INDEX:
              bmi = _convertToDouble(entry.value.value);
              bmiScore = calculateBMIScore(bmi);
              break;
            case HealthDataType.ACTIVE_ENERGY_BURNED:
              energyBurn = _convertToDouble(entry.value.value);
              energyScore = calculateEnergyScore(energyBurn);
              break;
            case HealthDataType.STEPS:
              steps = _convertToDouble(entry.value.value);
              stepsScore = calculateStepsScore(steps);
              break;
            case HealthDataType.DIETARY_CARBS_CONSUMED:
              diet = _convertToDouble(entry.value.value);
              dietScore = calculateDietScore(diet);
              break;
            case HealthDataType.RESTING_HEART_RATE:
              heartRate = _convertToDouble(entry.value.value);
              heartScore = calculateHeartScore(heartRate);
              break;
            case HealthDataType.RESPIRATORY_RATE:
              respiration = _convertToDouble(entry.value.value);
              respirationScore = calculateRespirationScore(respiration);
              break;
            case HealthDataType.SLEEP_IN_BED:
              sleep = _convertToDouble(entry.value.value) / 60; // Convert minutes to hours
              sleepScore = calculateSleepScore(sleep);
              break;
            case HealthDataType.BODY_TEMPERATURE:
              sunlight = _convertToDouble(entry.value.value); // Using temperature as a proxy for sunlight
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
  return min(
      100,
      (screenTime > upperBound)
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