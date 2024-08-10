import 'package:cloud_firestore/cloud_firestore.dart';

class BasicInfoModel {
  final String uid;
  final String selectedGender;
  final double age;
  final double height;
  final double weight;

  BasicInfoModel({
    required this.uid,
    required this.selectedGender,
    required this.age,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'selectedGender': selectedGender,
      'age': age,
      'height': height,
      'weight': weight,
    };
  }

  factory BasicInfoModel.fromMap(Map<String, dynamic> map) {
    return BasicInfoModel(
      uid: map['uid'],
      selectedGender: map['selectedGender'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
    );
  }


  Future<void> saveToFirestore() async {
    final userDoc = FirebaseFirestore.instance.collection('basic_info').doc(uid);
    await userDoc.set(toMap());
  }
}
