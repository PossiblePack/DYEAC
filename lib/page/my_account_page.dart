import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_seniorproject/data/NavBar.dart';

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('ข้อมูลผู้ใช้'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none_rounded),
              onPressed: () {/* Write listener code here */},
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
            ),
          ],
          backgroundColor: Colors.pink,
        ),
        body: Text("นายแพทย์"));
  }
}
