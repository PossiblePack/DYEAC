import 'package:flutter/material.dart';

class ChangeTimeToTakeMedicineWidget extends StatefulWidget {
  const ChangeTimeToTakeMedicineWidget({Key key}) : super(key: key);

  @override
  _ChangeTimeToTakeMedicineWidgetState createState() =>
      _ChangeTimeToTakeMedicineWidgetState();
}

class _ChangeTimeToTakeMedicineWidgetState
    extends State<ChangeTimeToTakeMedicineWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
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
                          fontSize: 20,
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Text(
                      '07:30',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sarabun',
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.schedule_sharp,
                    color: Colors.black,
                    size: 200,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      'คุณจะต้องหยอดตาในอีก 30 นาที',
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
                        'ครั้งที่ 1:                08:00',
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
                        print('Button pressed ...');
                      },
                      child: Text(
                        "แก้ไขเวลาหยอดตา",
                        style: TextStyle(
                          fontFamily: 'Sarabun',
                          color: Colors.black,
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
