import 'dart:ffi';

import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';
import 'package:kaizen/Pages/SplashPage/Splash_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:uuid/uuid.dart';

class AddFirstCardPage extends StatefulWidget {
  final kaizenlist;

  const AddFirstCardPage({Key? key, this.kaizenlist}) : super(key: key);

  @override
  _AddFirstCardPageState createState() => _AddFirstCardPageState();
}

class _AddFirstCardPageState extends State<AddFirstCardPage> {
  String _title = "";
  String _description = " ";
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  _submitAddCardForm() async {
    FocusScope.of(context).unfocus();
    if (checkFields(_formKey)) {
      setState(() {
        _isLoading = true;
      });
      KaizenCard kaizenCard = KaizenCard(Uuid().v1(), _title, _description);
      AddCard(context, widget.kaizenlist, kaizenCard).then((v) {
        setState(() {
          _isLoading = false;
        });
        ShowMessage().showAddAnotherCardMessage(context, widget.kaizenlist);
        // Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Card",
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: ConstantColors.purpleExtraDark),
        ),
        centerTitle: true,
        backgroundColor: ConstantColors.accentLightGrey,
        elevation: 0.0,
        leading: Container(),
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
                                  if (title!.length < 3)
                                    return "Title must be atleast 3 letters";
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    hintText: "Card Title",
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
                            padding:
                                const EdgeInsets.fromLTRB(15.0, 10.0, 0, 10),
                            child: Row(
                              children: [
                                Text(
                                  "List: ",
                                  style: GoogleFonts.lato(
                                      fontSize: 18,
                                      color: ConstantColors.purpleExtraDark,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.kaizenlist.listTitle,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    color: ConstantColors.purpleExtraDark,
                                  ),
                                )
                              ],
                            )),
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
                              maxLines: 20,
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
                                  hintText: "Add Card Description",
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
                        onPressed: _submitAddCardForm,
                        child: Text(
                          "Add Card",
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
