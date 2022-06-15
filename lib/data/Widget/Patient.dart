import 'package:flutter/material.dart';

import '../../page/change_time_page.dart';

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
          trailing: TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChangeTimeToTakeMedicineWidget();
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
