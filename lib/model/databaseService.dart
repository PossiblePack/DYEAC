import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('user');

  Future updateUserData(
    String name,
    String surname,
    String doctorname,
    String email,
    String password,
    String confirmpassword,
  ) async {
    return await userCollections.doc(uid).set({
      "name": name,
      "surname": surname,
      "doctorname": doctorname,
      "email": email,
      "password": password,
      "confirmpassword": confirmpassword
    });
  }
}
