import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/profile.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key key}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User user = FirebaseAuth.instance.currentUser;
  Profile loggedInUser = Profile();
  String avatarUrl;
  Bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getAvatar();
  }

  void getUserData() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = Profile.fromMap(value.data());
      getAvatar();
      setState(() {});
    });
  }

  void getAvatar() {
    if (loggedInUser.gender == 'ชาย') {
      avatarUrl = 'assets/images/male.png';
    } else {
      avatarUrl = 'assets/images/female.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFBBECFF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
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
                        padding: EdgeInsetsDirectional.fromSTEB(80, 10, 80, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Text(
                            'ข้อมูลของฉัน',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Container(
                            width: 125,
                            height: 125,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              child: Container(
                                child: Image.asset(
                                  '$avatarUrl',
                                ),
                              ),
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Text(
                              'ชื่อ: ${loggedInUser.name}  ${loggedInUser.surname}\nอีเมลล์: ${loggedInUser.email}\nหมายเลขประจำตัวประชาชน:\n1160701353629\nเพศ: ${loggedInUser.gender}\nเบอร์โทร: 099-999-9999\nแพทย์ผู้รับผิดชอบ: ${loggedInUser.doctorname}\nอาการป่วย: ระคายเคืองตา\n\nการนัดหมาย:\nวันที่ 31 ธันวาคม 2564 เวลา 09:00 น. \nห้องตรวจหมายเลข 10 โรงพยาบาลมหาราช\nเชียงใหม่\n\nพฤตกรรมการหยอดตา: \nสม่ำเสมอ ตรงเวลา',
                              style: TextStyle(
                                fontFamily: 'Sarabun',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width,
                      //     height: MediaQuery.of(context).size.height * 0.08,
                      //     decoration: BoxDecoration(
                      //       color: Color(0xFFBBECFF),
                      //     ),
                      //     alignment: AlignmentDirectional(0, 0),
                      //     child: ElevatedButton(
                      //       onPressed: () {
                      //         print('Button pressed ...');
                      //       },
                      //       child: Text(
                      //         "ติดต่อแพทย์",
                      //         style: TextStyle(
                      //           fontFamily: 'Sarabun',
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //       style: ElevatedButton.styleFrom(
                      //         minimumSize: Size(180, 40),
                      //         primary: Colors.white,
                      //         side: BorderSide(
                      //           color: Colors.black,
                      //           width: 1,
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
