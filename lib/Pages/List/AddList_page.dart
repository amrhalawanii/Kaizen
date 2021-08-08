import 'dart:ffi';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';
import 'package:kaizen/Pages/Card/AddFirstCard_Page.dart';
import 'package:kaizen/Pages/SplashPage/Splash_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:uuid/uuid.dart';

class AddListPage extends StatefulWidget {
  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  String _title = "";
  String _description = "";
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();
  _sumbitAddCardForm() async {
    FocusScope.of(context).unfocus();
    if (checkFields(_formKey)) {
      setState(() {
        _isLoading = true;
      });
      KaizenList list = KaizenList(_title, _description, Uuid().v1(), false, 0);
      AddList(context, list).then((v) {
        setState(() {
          _isLoading = false;
        });
        ShowMessage().showAchievementView(
            context,
            "Created Successfully!",
            "Please add your first card to ${_title}",
            Icon(
              Icons.playlist_add_sharp,
              color: Colors.white,
            ));
        Navigator.pushReplacement(
            context,
            PageTransition(AddFirstCardPage(
              kaizenlist: list,
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add List",
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: ConstantColors.purpleExtraDark),
        ),
        centerTitle: true,
        backgroundColor: ConstantColors.accentLightGrey,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xFF280B6F),
              size: 35,
            )),
      ),
      body: HomePageBackground(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: Device.width! * 0.85,
                height: Device.height! * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0xc4ffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x20000000),
                      offset: Offset(4, 3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Align(
                              alignment: Alignment.center,
                              child: TextFormField(
                                onSaved: (title) {
                                  setState(() {
                                    _title = title!;
                                  });
                                },
                                validator: (title) {
                                  if (title!.isEmpty || title == " ") {
                                    return "Title can't be empty";
                                  }
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Title",
                                    hintStyle: TextStyle(
                                        color: ConstantColors.purpleExtraDark
                                            .withOpacity(0.5)),
                                    focusColor: Colors.red,
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ConstantColors
                                                .purpleExtraDark))),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Description:",
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    color: ConstantColors.purpleExtraDark,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 25,
                              onSaved: (input) {
                                setState(() {
                                  _description = input!;
                                });
                              },
                              style: TextStyle(
                                  color: ConstantColors.purpleExtraDark),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  alignLabelWithHint: false,
                                  hintText: "Tell us about your list",
                                  labelStyle: TextStyle(
                                      color: ConstantColors.purpleExtraDark),
                                  hintStyle: TextStyle(
                                      color: ConstantColors.purpleExtraDark
                                          .withOpacity(0.5)),
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _isLoading
                ? ShowCircularProgressIndicator()
                : Container(
                    height: 50,
                    width: Device.width! * 0.8,
                    child: OutlinedButton(
                        onPressed: () {
                          _sumbitAddCardForm();
                        },
                        child: Text(
                          "Add List",
                          style: GoogleFonts.lato(
                              letterSpacing: 1,
                              fontSize: 16,
                              color: ConstantColors.accentLightGrey,
                              fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: ConstantColors.purpleExtraDark,
                          primary: ConstantColors.purpleDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                          ),
                        )),
                  ),
          ],
        ),
      )),
    );
  }
}
