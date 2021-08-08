import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/User.dart';

class Device {
  static double? height;
  static double? width;
}

class ConstantColors {
  static Color purpleDark = const Color(0xFF6730EC);
  static Color purpleLight = const Color(0xFF7984EE);
  static Color accentLightGrey = const Color(0xFFE4E4E4);
  static Color purpleExtraDark = const Color(0xFF280B6F);
}

class ConstantBackgrounds {
  static BoxDecoration purpleGradientBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment(-1.26, -1.17),
      end: Alignment(1.06, 1.07),
      colors: [
        const Color(0xffd2f6fc),
        const Color(0xff6730ec),
        const Color(0xff6730ec),
        const Color(0xff727272),
        const Color(0xff000000)
      ],
      stops: [0.0, 0.995, 1.0, 1.0, 1.0],
    ),
  );
}

class ConstantImages {
  static String registration = "assets/Registration/registration.png";
  static String backgroundItem1 = "assets/Background/background1.png";
  static String backgroundItem2 = "assets/Background/background2.png";
  static String selectList = "assets/checkList.png";
  static String randomCard = "assets/randomCard.png";
  static String splash = "assets/splash.png";
  static String contactUs = "assets/contactUs.png";
}

KaizenUser? activeUser;
List<KaizenList>? kaizenLists = [];

List<KaizenList> selectedList = [];
