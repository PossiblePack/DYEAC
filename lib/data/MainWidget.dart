import 'package:flutter/material.dart';
import 'package:my_seniorproject/page/Patient_detail.dart';

class MainWidget extends StatelessWidget {
  String patientName;
  String time;
  String minute;

  MainWidget(this.patientName, this.time, this.minute);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "สวัสดีคุณ\n$patientName",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Text(
            "ขณะนี้เวลา",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            "$time",
            style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
          ),
          Text(
            "คุณต้องหยอดตาในอีก ${minute} นาที",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
