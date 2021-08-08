import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:uuid/uuid.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  String _messageTitle = " ";
  String _messageDescription = " ";
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  _submitSendMessageForm() async {
    FocusScope.of(context).unfocus();
    if (checkFields(_formKey)) {
      setState(() {
        _isLoading = true;
      });
      sendFeedback(context, Uuid().v1(), _messageTitle, _messageDescription)
          .then((v) {
        ShowMessage().showAchievementView(
            context,
            "Thank You!",
            "Feedback sent successfully!",
            Icon(
              Icons.check,
              color: Colors.white,
            ));
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: GoogleFonts.lato(),
        ),
      ),
      body: HomePageBackground(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Leave us a message",
                    style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: ConstantColors.purpleDark)),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  ConstantImages.contactUs,
                  width: Device.width! * 0.7,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (title) {
                      setState(() {
                        _messageTitle = title!;
                      });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantColors.purpleExtraDark)),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantColors.purpleExtraDark)),
                        labelText: "Message Title ",
                        labelStyle: GoogleFonts.lato(
                            color: ConstantColors.purpleExtraDark)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    maxLines: 5,
                    onSaved: (message) {
                      setState(() {
                        _messageDescription = message!;
                      });
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantColors.purpleExtraDark)),
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: ConstantColors.purpleExtraDark)),
                        labelText: "Description Title ",
                        labelStyle: GoogleFonts.lato(
                            color: ConstantColors.purpleExtraDark)),
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
                            onPressed: _submitSendMessageForm,
                            child: Text(
                              "Send Message",
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
          ),
        ),
      )),
    );
  }
}
