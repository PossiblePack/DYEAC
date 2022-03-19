import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_seniorproject/data/MainWidget.dart';
import 'package:my_seniorproject/data/Patient.dart';
import 'package:my_seniorproject/data/NavBar.dart';
import 'package:my_seniorproject/page/Patient_detail.dart';
import 'package:my_seniorproject/page/my_account_page.dart';
import 'package:my_seniorproject/page/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'My home page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavBar(),
      // appBar: AppBar(
      //   title: Text(
      //     'รายชื่อผู้ป่วยในการดูแล',
      //     style: TextStyle(fontSize: 20),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.notifications_none_rounded),
      //       onPressed: () {/* Write listener code here */},
      //     ),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 5),
      //     ),
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 5),
      //     ),
      //   ],
      //   backgroundColor: Colors.pink,
      // ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 300,
          width: double.maxFinite,
          alignment: Alignment.center,
          child: ListView(
            children: [
              // Patient("สวัสดั", " 12:30 น. "),
              MainWidget("สมชาย สมหวังดังประสงค์", "18:00", "30")
            ],
          )),
      backgroundColor: Colors.lightBlue[200],
    );
  }
}
