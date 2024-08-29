import 'package:cloud_firestore/cloud_firestore.dart';

class BasicInfoModel {
  final String uid;
  final String selectedGender;
  final double age;
  final double height;
  final double weight;
  final String email;
  final String phoneNumber;

  BasicInfoModel({
    required this.uid,
    required this.selectedGender,
    required this.age,
    required this.height,
    required this.weight,
    required this.email,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'selectedGender': selectedGender,
      'age': age,
      'height': height,
      'weight': weight,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory BasicInfoModel.fromMap(Map<String, dynamic> map) {
    return BasicInfoModel(
      uid: map['uid'],
      selectedGender: map['selectedGender'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Future<void> saveToFirestore() async {
    final userDoc = FirebaseFirestore.instance.collection('basic_info').doc(uid);
    await userDoc.set(toMap());
  }
}
