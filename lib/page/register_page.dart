import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyeac/main.dart';
import 'package:dyeac/model/profile.dart';
import 'package:dyeac/page/login_page.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  SharedPreferences loginData;
  final auth = FirebaseAuth.instance;
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController confirmPasswordFieldController;
  bool confirmPasswordFieldVisibility;
  final TextEditingController doctorFieldController =
      new TextEditingController();
  final TextEditingController nameFieldController = new TextEditingController();
  final TextEditingController surnameFieldController =
      new TextEditingController();
  final TextEditingController usernameFieldController =
      new TextEditingController();
  final TextEditingController passwordFieldController =
      new TextEditingController();
  bool passwordFieldVisibility;

  @override
  void initState() {
    super.initState();
    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   Navigator.pop(context);
    // });

    confirmPasswordFieldController = TextEditingController();
    confirmPasswordFieldVisibility = false;
    passwordFieldVisibility = false;
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebase,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Error"),
            ),
            body: Center(child: Text("${snapshot.error}")),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xFFBBECFF),
            body: SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.03,
                          decoration: BoxDecoration(
                            color: Color(0xFFBBECFF),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(-1, 0),
                          child: InkWell(
                            onTap: () async {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Form(
                            key: formKey,
                            autovalidateMode: AutovalidateMode.always,
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFBBECFF),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          'สมัครบัญชีผู้ใช้ใหม่',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'ชื่อ',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText: "กรุณาใส่ชื่อของคุณ"),
                                        controller: nameFieldController,
                                        onSaved: (String name) {
                                          profile.name = name;
                                        },
                                        keyboardType: TextInputType.name,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'nameFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: nameFieldController
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () => setState(
                                                    () => nameFieldController
                                                        .clear(),
                                                  ),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF757575),
                                                    size: 22,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'นามสกุล',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText: "กรุณาใส่นามสกุลของคุณ"),
                                        controller: surnameFieldController,
                                        onSaved: (String surname) {
                                          profile.surname = surname;
                                        },
                                        keyboardType: TextInputType.name,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'surnameFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: surnameFieldController
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () => setState(
                                                    () => surnameFieldController
                                                        .clear(),
                                                  ),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF757575),
                                                    size: 22,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'ชื่อแพทย์ผู้ดูแล',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        controller: doctorFieldController,
                                        validator: RequiredValidator(
                                            errorText:
                                                "กรุณาใส่ชื่อแพทย์ผู้ดูแลของคุณ"),
                                        onSaved: (String doctorname) {
                                          profile.doctorname = doctorname;
                                        },
                                        keyboardType: TextInputType.name,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'doctorFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: doctorFieldController
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () => setState(
                                                    () => doctorFieldController
                                                        .clear(),
                                                  ),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF757575),
                                                    size: 22,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'อีเมล',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        controller: usernameFieldController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "กรุณาใส่อีเมลของคุณ"),
                                          EmailValidator(
                                              errorText:
                                                  "รูปแบบอีเมลไม่ถูกต้อง"),
                                        ]),
                                        onSaved: (String email) {
                                          profile.email = email;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'usernameFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: usernameFieldController
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () => setState(
                                                    () =>
                                                        usernameFieldController
                                                            .clear(),
                                                  ),
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF757575),
                                                    size: 22,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'รหัสผ่าน',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText:
                                                "กรุณาใส่รหัสผ่านของคุณ"),
                                        controller: passwordFieldController,
                                        onSaved: (String password) {
                                          profile.password = password;
                                        },
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'passwordFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: !passwordFieldVisibility,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => passwordFieldVisibility =
                                                  !passwordFieldVisibility,
                                            ),
                                            child: Icon(
                                              passwordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xFF757575),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        'ยืนยันรหัสผ่าน',
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
                                        validator: RequiredValidator(
                                            errorText:
                                                "กรุณาใส่รหัสผ่านของคุณอีกครั้ง"),
                                        controller:
                                            confirmPasswordFieldController,
                                        onSaved: (String confirmpassword) {
                                          profile.confirmpassword =
                                              confirmpassword;
                                        },
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'confirmPasswordFieldController',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText:
                                            !confirmPasswordFieldVisibility,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                              () => confirmPasswordFieldVisibility =
                                                  !confirmPasswordFieldVisibility,
                                            ),
                                            child: Icon(
                                              confirmPasswordFieldVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
                                              color: Color(0xFF757575),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFBBECFF),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 2, 0, 0),
                                        child: Text(
                                          'กรอกรหัสผ่านให้เหมือนกันกับช่องข้างบน',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 10, 0, 0),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            signUp(profile.email,
                                                profile.password);
                                          },
                                          child: Text(
                                            "สมัครบัญชีผู้ใช้",
                                            style: TextStyle(
                                                fontFamily: 'Sarabun',
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(200, 50),
                                            primary: Color(0xFF008AFF),
                                            side: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void signUp(String email, String password) async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save(); //Create profile to Auth
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: profile.email,
        password: profile.password,
      )
          .then((value) {
        //Create profile to Firestore
        postDetailToFirestore();
        formKey.currentState.reset();
      }).catchError((e) {
        print(e.code);
        String message;
        if (e.code == 'email-already-in-use') {
          message = "มีอีเมลนี้อยู่แล้ว กรุณาใช้อีเมลอื่นแทน";
        }
        if (e.code == 'weak-password') {
          message = "รหัสผ่านต้องมีความยาวอย่างน้อย 6 ตัวอักษร";
        } else {
          message = e.message;
        }
        Fluttertoast.showToast(
            msg: message, gravity: ToastGravity.CENTER, fontSize: 18);
      });
    }
  }

  void postDetailToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User user = auth.currentUser;
    Profile profile = Profile();

    profile.uid = user.uid;
    profile.email = user.email;
    profile.name = nameFieldController.text;
    profile.surname = surnameFieldController.text;
    profile.doctorname = doctorFieldController.text;
    profile.password = passwordFieldController.text;
    profile.confirmpassword = confirmPasswordFieldController.text;

    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(profile.toMap());
    Fluttertoast.showToast(
      msg: "สร้างบัญชีผู้ใช้สำเร็จแล้ว",
      gravity: ToastGravity.CENTER,
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginWidget();
    }));
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
  }
}
