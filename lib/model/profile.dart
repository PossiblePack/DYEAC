class Profile {
  String uid;
  String name;
  String surname;
  String doctorname;
  String email;
  String password;
  String confirmpassword;

  Profile(
      {this.uid,
      this.name,
      this.surname,
      this.doctorname,
      this.email,
      this.password,
      this.confirmpassword});

  factory Profile.fromMap(map) {
    return Profile(
      uid: map['uid'],
      name: map['name'],
      surname: map['surname'],
      doctorname: map['doctorname'],
      email: map['email'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'surname': surname,
      'doctorname': doctorname,
      'email': email,
      'password': password,
      'confirmpassword': confirmpassword,
    };
  }
}
