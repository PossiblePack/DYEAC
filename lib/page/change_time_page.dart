import 'dart:async';
import 'package:flutter/material.dart';
import '../api/notification_api.dart';
import '../data/Widget/Clock.dart';
import 'dart:math';
import 'medicine_information_page.dart';

class ChangeTimeToTakeMedicineWidget extends StatefulWidget {
  const ChangeTimeToTakeMedicineWidget({Key key}) : super(key: key);

  @override
  _ChangeTimeToTakeMedicineWidgetState createState() =>
      _ChangeTimeToTakeMedicineWidgetState();
}

class _ChangeTimeToTakeMedicineWidgetState
    extends State<ChangeTimeToTakeMedicineWidget> {
  int H, h, m, s, hour, minute;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  TimeOfDay firstTimeAlarm = TimeOfDay(hour: 8, minute: 00);

  String compareTime(firstTimeAlarm) {
    int hour = (firstTimeAlarm.hour - DateTime.now().hour);
    int minute = (firstTimeAlarm.minute - DateTime.now().minute);
    if (minute < 0) {
      hour -= 1;
      minute = 60 - minute.abs();
    }
    if (hour <= 0) {
      hour = 24 - hour.abs();
    }
    if (hour == 0 && minute == 0) {
      print('alarm');
    }
    return '$hour ชั่วโมง $minute นาที ';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showTime();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
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
    if (this.mounted) {
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
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'ขณะนี้เวลา',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                      child: Text(
                        '${(H < 10) ? "0$H" : H}:${(m < 10) ? "0$m" : m}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 70,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Clock(),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: Text(
                        'คุณจะต้องหยอดตาในอีก ${compareTime(firstTimeAlarm)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                        width: 100,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'ครั้งที่ 1:            ${firstTimeAlarm.format(context)}',
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                        width: 100,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'ครั้งที่ 2:                12:00',
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                      child: Container(
                        width: 100,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Text(
                          'ครั้งที่ 3:                18:00',
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Color(0xFFBBECFF),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          _showTimePicker();
                        },
                        child: Text(
                          "แก้ไขเวลาหยอดตา",
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(180, 40),
                          primary: Colors.white,
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.08,
                      decoration: BoxDecoration(
                        color: Color(0xFFBBECFF),
                      ),
                      alignment: AlignmentDirectional(0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          NotificationApi.showScheduleNotification(
                            title: 'การแจ้งเตือนการหยอดตา',
                            body: 'ถึงเวลาที่จะต้องทำการหยอดตาแล้ว',
                            payload: 'eiei',
                            scheduleDate:
                                DateTime.now().add(Duration(seconds: 5)),
                          );
                          final snackBar = SnackBar(
                            content: Text(
                              'Schedule in 5 seconds',
                            ),
                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(snackBar);
                          // NotificationApi.showNotification(
                          //   title: 'การแจ้งเตือนการหยอดตา',
                          //   body: 'ถึงเวลาที่จะต้องทำการหยอดตาแล้ว',
                          //   payload: 'eiei',
                          // );
                        },
                        child: Text(
                          "เด้ง notification",
                          style: TextStyle(
                            fontFamily: 'Sarabun',
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(180, 40),
                          primary: Colors.white,
                          side: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _showTimePicker() {
    showTimePicker(
        context: context,
        initialTime: firstTimeAlarm,
        builder: (context, childWidget) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: childWidget);
        }).then((value) {
      if(mounted){
        setState(() {
        if (value == null) {
        } else {
          firstTimeAlarm = value;
        }
      });
      }
    });
  }
}
