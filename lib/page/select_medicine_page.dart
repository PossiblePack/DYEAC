import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyeac/model/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/medicine.dart';
import 'change_time_page.dart';

class SelectMedicineWidget extends StatefulWidget {
  const SelectMedicineWidget({Key key}) : super(key: key);

  @override
  _SelectMedicineWidgetState createState() => _SelectMedicineWidgetState();
}

class _SelectMedicineWidgetState extends State<SelectMedicineWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  User user = FirebaseAuth.instance.currentUser;
  Profile loggedInUser = Profile();
  Medicine medicine = Medicine();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showUserData();
  }

  void showUserData() {
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .get()
        .then((value) {
      this.loggedInUser = Profile.fromMap(value.data());
      setState(() {});
    });
  }

  Widget buildMedicine(Medicine medicine) => ListTile(
        leading: CircleAvatar(
          child: Text('${medicine.useOptionID}'),
        ),
        title: Text('${medicine.medicineName}'),
      );

  Stream<List<Medicine>> readMedicine() => FirebaseFirestore.instance
      .collection("medicine")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Medicine.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFBBECFF),
        body: StreamBuilder<List<Medicine>>(
            stream: readMedicine(),
            builder: (context, snapshot) {
              return SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
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
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Text(
                                    'ระบบปรับเปลี่ยนเวลาการหยอดตา',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                          child: Text(
                            'กรุณาเลือกชนิดยาที่ท่านต้องการปรับเปลี่ยนเวลา',
                            style: TextStyle(
                              fontFamily: 'Sarabun',
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                          child: InkWell(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeTimeToTakeMedicineWidget(),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        15, 0, 0, 0),
                                    child: Image.asset(
                                      'assets/images/1.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 8, 10, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 0, 0, 0),
                                              child: Text(
                                                'ชื่อยา: DexOph\nเวลาหยอดครั้งต่อไป\n',
                                                style: TextStyle(
                                                  fontFamily: 'Sarabun',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 0, 10, 0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              '08:00',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontFamily: 'Sarabun',
                                                fontSize: 39,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text('${loggedInUser.prescriptionNO}'),
                        Text('${medicine.medicineName}')
                      ],
                    ),
                  ),
                ),
              );
              //   return ListView(
              //       children: Medicine.fromMap(buildMedicine(medicine)).toList());
              // }),
            }));
  }
}
