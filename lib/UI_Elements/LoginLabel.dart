import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/Registration/Login_Page.dart';

Widget LoginLabel() {
  return Stack(
    alignment: Alignment.topLeft,
    children: <Widget>[
      Positioned(
          bottom: 0,
          right: 0,
          child: CustomPaint(
            painter: Drawhorizontalline(),
          )),
      Positioned(
        top: 0,
        left: 0,
        child: Text(
          'Login'.toUpperCase(),
          style: TextStyle(
              fontFamily: 'Corbel',
              fontWeight: FontWeight.w400,
              fontSize: Device.height! * 0.105,
              color: const Color(0xffffffff),
              height: 1.5,
              shadows: [
                Shadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 10),
                    blurRadius: 6),
              ]),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}
