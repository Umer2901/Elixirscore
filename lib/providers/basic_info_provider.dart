import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_elixirscore/model/basic_info_model.dart';

class BasicInfoProvider with ChangeNotifier {
  BasicInfoModel? _basicInfo;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BasicInfoModel? get basicInfo => _basicInfo;

  Future<void> loadBasicInfo() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('basic_info').doc(uid).get();
      if (doc.exists) {
        _basicInfo = BasicInfoModel.fromMap(doc.data()!);
        notifyListeners();
      }
    }
  }

  Future<void> updateBasicInfo(String gender, double age, double height, double weight) async {
    final user = _auth.currentUser;
    if (user != null) {
      final email = user.email ?? '';
      final phoneNumber = user.phoneNumber ?? '';

      _basicInfo = BasicInfoModel(
        uid: user.uid,
        selectedGender: gender,
        age: age,
        height: height,
        weight: weight,
        email: email,
        phoneNumber: phoneNumber,
      );
      await _basicInfo!.saveToFirestore();
      notifyListeners();
    }
  }
}
