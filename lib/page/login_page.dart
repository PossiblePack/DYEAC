import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_seniorproject/data/NavBar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text('ลงชื่อเข้าใช้'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications_none_rounded),
              onPressed: () {/* Write listener code here */},
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
