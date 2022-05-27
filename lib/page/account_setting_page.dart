import 'package:flutter/material.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ตั้งค่าบัญชีผู้ใช้'),
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
