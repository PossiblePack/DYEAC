import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyeac/api/notification_api.dart';
import 'package:dyeac/model/profile.dart';
import 'package:dyeac/page/account_setting_page.dart';
import 'package:dyeac/page/change_time_page.dart';
import 'package:dyeac/page/login_page.dart';
import 'package:dyeac/page/medicine_information_page.dart';
import 'package:dyeac/page/register_page.dart';
import 'package:dyeac/page/select_medicine_page.dart';
import 'package:dyeac/page/treatment_history.dart';
import 'package:dyeac/page/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFFBBECFF),
      ),
      home: LoginWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}   

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final _unfocusNode = FocusNode();
  int H, h, m, s, hour, minute;
  SharedPreferences loginData;
  User user = FirebaseAuth.instance.currentUser;
  bool newuser;
  Profile loggedInUser = Profile();
  Profile profile = Profile();

  @override
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final auth = FirebaseAuth.instance;
  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  );

  @override
  void initState() {
    super.initState();
    initial();
    checkStateLogin();
    showTime();
    NotificationApi.init(initSchedule: true);
    listenNotification();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  void listenNotification() =>
      NotificationApi.onNotification.stream.listen(onClickNotification);

  void onClickNotification(String payload) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MedicineInformationWidget(payload: payload)),
      );

  void initial() async {
    loginData = await SharedPreferences.getInstance();
  }

  void checkStateLogin() async {
    loginData = await SharedPreferences.getInstance();
    newuser = (loginData.getBool('login') ?? true);

    if (loginData.getBool('login') == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => LoginWidget()));
    } else {
      showUserData();
    }
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

  void showTime() {
    H = DateTime.now().hour;
    //12 hour AM/PM
    h = (DateTime.now().hour > 12)
        ? DateTime.now().hour - 12
        : (DateTime.now().hour == 0)
            ? 12
            : DateTime.now().hour;
    m = DateTime.now().minute;
    s = DateTime.now().second;
    Timer.periodic(Duration(seconds: 1), (Timer timer) => getTime());
  }

  getTime() {
    if(mounted){
      setState(() {
        H = DateTime.now().hour;
        // 12 hour AM/PM
        h = (DateTime.now().hour > 12)
            ? DateTime.now().hour - 12
            : (DateTime.now().hour == 0)
                ? 12
                : DateTime.now().hour;
        m = DateTime.now().minute;
        s = DateTime.now().second;
      });
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBBECFF),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                              child: Text(
                                'สวัสดีคุณ ${loggedInUser.name} ${loggedInUser.surname}',
                                style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'ขณะนี้เวลา',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                '${(H < 10) ? "0$H" : H}:${(m < 10) ? "0$m" : m}',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'คุณจะต้องหยอดตาในอีก 30 นาที',
                                style: TextStyle(
                                  fontFamily: 'Sarabun',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.155,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBBECFF),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: GridView(
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.6,
                                    ),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePageWidget()),
                                        ),
                                        label: Text(
                                          "ข้อมูลของฉัน",
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            color: Colors.black,
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.account_circle_outlined,
                                          size: 50,
                                          color: Colors.black,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color(0xFFFFFFFFF), // background
                                          minimumSize: Size(200, 200),
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          shape: shape,
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TreatmentHistoryWidget()),
                                        ),
                                        label: Text(
                                          "ประวัติการรักษา",
                                          style: TextStyle(
                                            fontFamily: 'Sarabun',
                                            color: Colors.black,
                                          ),
                                        ),
                                        icon: Icon(
                                          Icons.assignment_rounded,
                                          size: 40,
                                          color: Colors.black,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Color(0xFFFFFFFFF), // background
                                          minimumSize: Size(200, 200),
                                          side: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          shape: shape,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBBECFF),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Color(0xFFFBBECFF),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                        SelectMedicineWidget()
                                        ),
                                  ),
                                  label: Text(
                                    "เปลี่ยนเวลาหยอดตา",
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      color: Colors.black,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.schedule_sharp,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFFFFFFF), // background
                                    minimumSize: Size(130, 60),
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: shape,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.13,
                            decoration: BoxDecoration(
                              color: Color(0xFFFBBECFF),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: ElevatedButton.icon(
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AccountSettingPage()),
                                ),
                                label: Text(
                                  "ตั้งค่าบัญชีผู้ใช้",
                                  style: TextStyle(
                                    fontFamily: 'Sarabun',
                                    color: Colors.black,
                                  ),
                                ),
                                icon: Icon(
                                  Icons.miscellaneous_services_sharp,
                                  size: 50,
                                  color: Colors.black,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFFFFFF), // background
                                  minimumSize: Size(130, 60),
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  shape: shape,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Color(0xFFFBBECFF),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 0, 20, 0),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    auth.signOut().then((value) {
                                      loginData.setBool('login', false);
                                      print(loginData);
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginWidget()));
                                    });
                                  },
                                  label: Text(
                                    "ออกจากระบบ",
                                    style: TextStyle(
                                      fontFamily: 'Sarabun',
                                      color: Colors.black,
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.logout,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFFFFFFF), // background
                                    minimumSize: Size(130, 60),
                                    side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    shape: shape,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
