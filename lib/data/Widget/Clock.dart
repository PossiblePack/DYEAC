import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({Key key}) : super(key: key);

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  double minuteAngle = 0;
  double secondAngle = 0;
  double hourAngle = 0;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      final now = DateTime.now();
      setState(() {
        secondAngle = (pi / 30) * now.second;
        minuteAngle = pi / 30 * now.minute;
        hourAngle = (pi / 6 * now.hour) + (pi / 45 * minuteAngle);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            child: Container(
              child: CircleAvatar(backgroundColor: Colors.white),
              height: 250,
              width: 250,
            ),
            alignment: Alignment(0, 0),
          ),
          Image.asset('assets/images/clock.png'),
          //second line
          Transform.rotate(
            child: Container(
              child: Container(
                height: 120,
                width: 2,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              alignment: Alignment(0, -0.35),
            ),
            angle: secondAngle,
          ),
          //minute line
          Transform.rotate(
            child: Container(
              child: Container(
                height: 80,
                width: 5,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              alignment: Alignment(0, -0.35),
            ),
            angle: minuteAngle,
          ),
          //hour line
          Transform.rotate(
            child: Container(
              child: Container(
                height: 80,
                width: 7,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              alignment: Alignment(0, -0.2),
            ),
            angle: hourAngle,
          ),
          //dot
          Container(
            child: Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            alignment: Alignment(0, 0),
          ),
        ],
      ),
      width: 250,
      height: 250,
    );
  }
}
