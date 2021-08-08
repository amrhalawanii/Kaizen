import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/UI_Elements/HorizontalLine.dart';

Widget KaizenLabel() {
  return Container(
    width: Device.width! * 0.85,
    // height: 150,
    // color: Colors.yellow,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'KAIZEN',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 80,
            color: ConstantColors.purpleDark,
            shadows: [
              Shadow(
                color: ConstantColors.purpleLight,
                offset: Offset(4, 4),
                blurRadius: 15,
              )
            ],
          ),
          // textAlign: TextAlign.left,
        ),
        SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ConstantColors.purpleDark,
                  // spreadRadius: 2,
                  blurRadius: 15,
                  offset: Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            child: CustomPaint(
              painter: Drawhorizontalline(),
            )),
        SizedBox(height: 30),
        Text(
          'First you make your habits, then your habits make you',
          style: TextStyle(
            fontFamily: 'Calibri',
            fontSize: 14,
            color: const Color(0xff280b6f),
          ),
        ),
      ],
    ),
  );
}
