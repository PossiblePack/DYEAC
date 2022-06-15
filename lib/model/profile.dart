import 'dart:ffi';

class Profile {
  String uid;
  String name;
  String surname;
  String doctorname;
  String gender;
  String email;
  String password;
  String confirmpassword;
  // Array prescriptionNO;

  Profile({
    this.uid,
    this.name,
    this.surname,
    this.doctorname,
    this.gender,
    this.email,
    this.password,
    this.confirmpassword,
    // this.prescriptionNO,
  });

  factory Profile.fromMap(map) {
    return Profile(
      uid: map['uid'],
      name: map['name'],
      surname: map['surname'],
      doctorname: map['doctorname'],
      gender: map['gender'],
      email: map['email'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
      // prescriptionNO: map['prescriptionNO'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'doctorname': doctorname,
      'gender': gender,
      'email': email,
      'password': password,
      'confirmpassword': confirmpassword,
      // 'prescriptionNO': prescriptionNO,
    };
  }
}
