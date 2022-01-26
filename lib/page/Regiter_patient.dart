import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_seniorproject/data/NavBar.dart';

class Regiter_Patient extends StatelessWidget {
  const Regiter_Patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('ลงทะเบียนผู้ป่วยใหม่'),
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
        body: Text("นาย ก"));
  }
}
