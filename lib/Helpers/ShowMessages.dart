import 'package:achievement_view/achievement_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';
import 'package:kaizen/Pages/Card/AddFirstCard_Page.dart';
import 'package:kaizen/Pages/List/SelectList_page.dart';
import 'package:kaizen/Pages/SplashPage/Splash_Page.dart';

class ShowMessage {
  //Error Dialogs
  showErrorDialog(BuildContext context, title, message) {
    AwesomeDialog(
            width: 500,
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            headerAnimationLoop: false,
            title: title,
            desc: message,
            btnOkColor: Colors.red,
            btnOkOnPress: () {})
        .show();
  }

  showAchievementView(BuildContext context, title, subTitle, icon) {
    AchievementView(context,
            alignment: Alignment.center,
            title: title,
            subTitle: subTitle,
            isCircle: true,
            icon: icon,
            color: ConstantColors.purpleDark,
            duration: Duration(seconds: 3))
        .show();
  }

  showAddAnotherCardMessage(BuildContext context, KaizenList list) {
    AwesomeDialog(
        width: 500,
        context: context,
        dialogType: DialogType.QUESTION,
        animType: AnimType.SCALE,
        headerAnimationLoop: false,
        title: "Card Added Successfully!",
        desc: "Would you like to add another one?",
        btnOkColor: ConstantColors.purpleExtraDark,
        btnOkText: "Yes",
        btnOkOnPress: () {
          Navigator.pushReplacement(
              context,
              PageTransition(AddFirstCardPage(
                kaizenlist: list,
              )));
        },
        btnCancelText: "Cancel",
        buttonsTextStyle: GoogleFonts.lato(color: Colors.white),
        btnCancelColor: Colors.grey[700],
        btnCancelOnPress: () {
          Navigator.pushReplacement(context, PageTransition(SelectListPage()));
        }).show();
  }
}
