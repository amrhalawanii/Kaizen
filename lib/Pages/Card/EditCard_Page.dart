import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/List/ViewList_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';

class EditCardPage extends StatefulWidget {
  final KaizenCard kaizenCard;
  final KaizenList kaizenList;
  const EditCardPage(
      {Key? key, required this.kaizenCard, required this.kaizenList})
      : super(key: key);

  @override
  _EditCardPageState createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  String _title = "";
  String _description = " ";
  bool _isLoading = false;
  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  @override
  void initState() {
    setState(() {
      titleController.text = widget.kaizenCard.cardTitle.toString();
      descriptionController.text = widget.kaizenCard.cardDescription.toString();
    });
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey();

  _submitUpdateCardForm() {
    FocusScope.of(context).unfocus();
    if (checkFields(_formKey)) {
      setState(() {
        _isLoading = false;
      });
      KaizenCard kaizenCard =
          KaizenCard(widget.kaizenCard.cardId, _title, _description);
      updateCard(context, widget.kaizenList, kaizenCard).then((v) {
        setState(() {
          _isLoading = false;
        });
        ShowMessage().showAchievementView(
            context,
            "Changed Successfully",
            "Your card has been changed Successfully!",
            Icon(Icons.check, color: Colors.white));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ViewListPage(kaizenList: widget.kaizenList)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Card",
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
                                controller: titleController,
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
                                  widget.kaizenList.listTitle,
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
                              controller: descriptionController,
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
                        onPressed: _submitUpdateCardForm,
                        child: Text(
                          "Update Card",
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
