import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationDatabaseService {
  final String uid;
  ApplicationDatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('applications');

  Future updateUserData(
    String name,
    String gender,
    int age,
    int pincode,
    bool medCond,
    String email,
    int phone,
    bool covidB4,
  ) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'age': age,
      'pincode': pincode,
      'medCond': medCond,
      'email': email,
      'phone': phone,
      'covidB4': covidB4,
    });
  }
}
