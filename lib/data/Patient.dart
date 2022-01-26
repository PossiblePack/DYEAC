import 'package:flutter/material.dart';
import 'package:my_seniorproject/page/Patient_detail.dart';

class Patient extends StatelessWidget {
  String fullnameVal;
  String timeVal;

  Patient(this.fullnameVal, this.timeVal);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        ListTile(
          minVerticalPadding: 6,
          horizontalTitleGap: 5,
          title: Text(
            fullnameVal.toString(),
            style: TextStyle(fontSize: 25),
          ),
          subtitle: Text(
            "หยอดตาครั้งล่าสุดเมื่อเวลา $timeVal",
            style: TextStyle(fontSize: 15),
          ),
          trailing: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PatientDetail();
              }));
            },
            child: Text('ดูเพิ่มเติม'),
          ),
        )
        //
      ],
    ));
  }
}
