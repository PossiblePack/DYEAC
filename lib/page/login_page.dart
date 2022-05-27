import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyeac/main.dart';
import 'package:dyeac/page/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  SharedPreferences loginData;
  bool newuser;
  Profile loggedInUser = Profile();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textController1;
  TextEditingController textController2;
  bool passwordVisibility;
  Profile profile = Profile();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility = false;
    initial();
    checkStateLogin();
  }

  void checkStateLogin() async {
    loginData = await SharedPreferences.getInstance();
    if (loginData == true) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => HomePageWidget()));
    }
  }

  void initial() async {
    loginData = await SharedPreferences.getInstance();
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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Text(
                              'โปรแกรมสำหรับผู้ป่วยโรคตา',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Text(
                            'Mobile Application for Ophthalmic Patients',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.width * 0.35,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/eye-drops.png',
                              ),
                            ),
                          ),
                          Text(
                            'กรุณาเข้าสู่ระบบก่อนเข้าใช้งาน',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                            child: Form(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'อีเมล',
                                      style: TextStyle(
                                        fontFamily: 'Sarabun',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: TextFormField(
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
                                        controller: textController1,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'textController1',
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
                                        ),
                                        style: TextStyle(
                                          fontFamily: 'Sarabun',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                        onSaved: (String password) {
                                          profile.password = password;
                                        },
                                        controller: textController2,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          'textController2',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        autofocus: true,
                                        obscureText: !passwordVisibility,
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
                                              () => passwordVisibility =
                                                  passwordVisibility,
                                            ),
                                            child: Icon(
                                              passwordVisibility
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
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            if (formKey.currentState
                                                .validate()) {
                                              formKey.currentState.save();
                                              try {
                                                await FirebaseAuth.instance
                                                    .signInWithEmailAndPassword(
                                                  email: profile.email,
                                                  password: profile.password,
                                                )
                                                    .then((value) {
                                                  loginData.setBool(
                                                      'login', true);
                                                  formKey.currentState.reset();
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return HomePageWidget();
                                                  }));
                                                });
                                              } on FirebaseAuthException catch (e) {
                                                Fluttertoast.showToast(
                                                    msg: e.message,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    fontSize: 18);
                                              }
                                            }
                                          },
                                          label: Text(
                                            "เข้าสู่ระบบ",
                                            style: TextStyle(
                                              fontFamily: 'Sarabun',
                                              color: Colors.white,
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.login,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(200, 40),
                                            primary: Color(0xFF008AFF),
                                            side: BorderSide(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          print('Button pressed ...');
                                        },
                                        child: Text(
                                          "ลืมรหัสผ่าน",
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            color: Color(0xFF024F91),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(200, 40),
                                            primary: Color(0xFFBBECFF),
                                            side: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.black,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Text(
                              'คุณยังไม่มีบัญชีผู้ใช้ใช่หรือไม่',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                await Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterWidget(),
                                  ),
                                );
                              },
                              child: Text(
                                "สมัครบัญชีผู้ใหม่",
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  color: Color(0xFF024F91),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 40),
                                  primary: Color(0xFFBBECFF),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
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
        });
  }
}
