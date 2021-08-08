import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/Registration/Login_Page.dart';
import 'package:kaizen/Pages/Registration/Signup_page.dart';
import 'package:kaizen/UI_Elements/KaizenLabel.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    Device.width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: ConstantColors.accentLightGrey,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            Center(child: KaizenLabel()),
            Container(
                width: Device.width! * 0.7,
                child: Image.asset(ConstantImages.registration)),
            ButtonsRow(context)
          ],
        ));
  }
}

Widget ButtonsRow(BuildContext context) {
  return Container(
    width: Device.width! * 0.85,
    height: 75,
    // color: Colors.blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          // width: Device.width * 0.14,
          height: 45,
          child: FlatButton(
            minWidth: 156,
            // height: 70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              side: BorderSide(color: ConstantColors.purpleDark, width: 2),
            ),
            child: Text("Login",
                style: TextStyle(color: ConstantColors.purpleDark)),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ),
        Container(
          // width: Device.width * 0.14,
          height: 45,
          child: FlatButton(
            minWidth: 156,
            // minWidth: 250,
            // height: 70,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            color: ConstantColors.purpleDark,
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SignupPage()));
            },
          ),
        ),
      ],
    ),
  );
}
