import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/List/ViewList_Page.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';

class EditListPage extends StatefulWidget {
  final KaizenList kaizenList;
  const EditListPage({Key? key, required this.kaizenList}) : super(key: key);

  @override
  _EditListPageState createState() => _EditListPageState();
}

class _EditListPageState extends State<EditListPage> {
  String _title = "";
  String _description = "";
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController titleController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  _submitUpdatePage() async {
    FocusScope.of(context).unfocus();
    if (checkFields(_formKey)) {
      setState(() {
        _isLoading = false;
      });
      KaizenList list = KaizenList(_title, _description,
          widget.kaizenList.listId, false, widget.kaizenList.numberOfCards);
      updateList(context, list).then((v) {
        setState(() {
          _isLoading = false;
        });
        getLists();
        ShowMessage().showAchievementView(
            context,
            "Changed Successfully",
            "Your list has been changed Successfully!",
            Icon(Icons.check, color: Colors.white));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ViewListPage(kaizenList: list)));
      });
    }
  }

  @override
  void initState() {
    titleController.text = widget.kaizenList.listTitle;
    descriptionController.text = widget.kaizenList.listDescription;
    super.initState();
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
                                controller: titleController,
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
                                    // hintText: "Title",
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
                              controller: descriptionController,
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
                                  // hintText: "Tell us about your list",
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
                          _submitUpdatePage();
                        },
                        child: Text(
                          "Update List",
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
