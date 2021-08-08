import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Configuration/auth.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/User.dart';
import 'package:kaizen/Pages/Registration/Login_Page.dart';
import 'package:kaizen/Pages/List/SelectList_page.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:kaizen/UI_Elements/SignupLabel.dart';
import 'package:password_strength/password_strength.dart';
import 'package:uuid/uuid.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;

  //User Info
  String _username = "";
  String _emailAddress = "";
  String _password = "";
  String _confirmationPassword = "";

  final GlobalKey<FormState> _formKey = GlobalKey();
  _submitSignUpFrom() async {
    FocusScope.of(context).unfocus();
    if (checkFields()) {
      setState(() {
        _isLoading = true;
      });

      // KaizenUser user = KaizenUser(Uuid().v1(), _username, _emailAddress);
      // print(user.email);

      AuthServices()
          .createAccount(context, _emailAddress, _username, _password)
          .then((v) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool _hidePassword = true;
    Device.height = MediaQuery.of(context).size.height;
    Device.width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Device.height,
          width: Device.width,
          decoration: ConstantBackgrounds.purpleGradientBackground,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    // SizedBox(
                    //   width: 10,
                    // ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 30,
                        ))
                  ],
                ),
                Container(
                  // color: Colors.green,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //------------------------------------------------------------------
                      //------------------------ Signup Label -----------------------------
                      //------------------------------------------------------------------
                      Container(
                        // color: Colors.red,
                        width: Device.width! * 0.8,
                        height: Device.height! * 0.16,
                        child: SignupLabel(),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //------------------------------------------------------------------
                      //------------------------ Signup Form ------------------------------
                      //------------------------------------------------------------------

                      Container(
                        // color: Colors.blue[800],
                        width: Device.width! * 0.8,
                        // height: Device.height! * 0.6,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //-----------------------------------------------------------------
                              //-------------------------- Username ------------------------------
                              //------------------------------------------------------------------
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (username) {
                                  setState(() {
                                    _username = username.toString().trim();
                                  });
                                },
                                validator: (username) {
                                  if (username!.length < 6) {
                                    return "Username must be atleast 6 letters";
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Username",
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.person_outline_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Corbel',
                                        fontSize: 18),
                                    focusColor: Colors.white12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //------------------------------------------------------------------
                              //-------------------------- Email Address -------------------------
                              //------------------------------------------------------------------
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (email) {
                                  setState(() {
                                    _emailAddress = email.toString().trim();
                                  });
                                },
                                validator: (email) {
                                  if (!EmailValidator.validate(email!)) {
                                    return "Please insert a valid email";
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                decoration: InputDecoration(
                                    labelText: "Email Address",
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.email_outlined,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Corbel',
                                        fontSize: 18),
                                    focusColor: Colors.white12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //------------------------------------------------------------------
                              //-------------------------- Password ------------------------------
                              //------------------------------------------------------------------
                              TextFormField(
                                onSaved: (password) {
                                  setState(() {
                                    _password = password.toString();
                                  });
                                },
                                validator: (password) {
                                  if (estimatePasswordStrength(password!) <
                                      0.3) {
                                    print(estimatePasswordStrength(password));
                                    return "Password is too weak";
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: _hidePassword ? true : false,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.lock_outline_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Corbel',
                                        fontSize: 18),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      },
                                      child: Icon(
                                        Icons.visibility_off_rounded,
                                        size: 18,
                                        // color: Color(0xFF474646),
                                        color: Colors.white,
                                      ),
                                    ),
                                    focusColor: Colors.white12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              //------------------------------------------------------------------
                              //--------------------------Confirm Password -----------------------
                              //------------------------------------------------------------------
                              TextFormField(
                                onSaved: (password) {
                                  setState(() {
                                    _confirmationPassword = password.toString();
                                  });
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Confirm Password",
                                    prefixIcon: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Icon(
                                        Icons.lock_outline_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white12,
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(27),
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide:
                                            BorderSide(color: Colors.red)),
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Corbel',
                                        fontSize: 18),
                                    focusColor: Colors.white12),
                              ),

                              SizedBox(
                                height: 20,
                              ),
                              //------------------------------------------------------------------
                              //-------------------------- Signup Button --------------------------
                              //------------------------------------------------------------------

                              _isLoading
                                  ? ShowCircularProgressIndicator()
                                  : Container(
                                      width: 230,
                                      height: 55,
                                      // color: Colors.red,
                                      child: FlatButton(
                                        onPressed: _submitSignUpFrom,
                                        color: ConstantColors.accentLightGrey,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(32),
                                            bottomLeft:
                                                const Radius.circular(32),
                                            bottomRight:
                                                const Radius.circular(32),
                                          ),
                                        ),
                                        child: Text(
                                          'SIGNUP',
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: 'Corbel',
                                              color: ConstantColors.purpleDark,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                              // SizedBox(
                              //   height: 30,
                              // ),

                              SizedBox(
                                height: 10,
                              ),
                              //------------------------------------------------------------------
                              //-------------------------- Login With ----------------------------
                              //------------------------------------------------------------------
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("or continue with",
                                      style: TextStyle(
                                          fontFamily: 'Corbel',
                                          fontSize: 20,
                                          color: const Color(0xffffffff),
                                          letterSpacing: 0.14,
                                          fontWeight: FontWeight.w300,
                                          height: 1.25)),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      SignupWith('loginGoogle.png', () {}),
                                      Platform.isIOS
                                          ? SignupWith('loginApple.png', () {})
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      //------------------------------------------------------------------
                      //--------------------------- Login ------------------------------
                      //------------------------------------------------------------------
                      Container(
                        width: Device.width! * 0.7,
                        // color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                fontFamily: 'Corbel',
                                fontSize: Device.height! * 0.0235,
                                color: const Color(0xa8ffffff),
                                letterSpacing: 0.126,
                                height: 1.3888888888888888,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  color: const Color(0xffffffff),
                                  fontFamily: 'Corbel',
                                  fontSize: Device.height! * 0.0235,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget SignupWith(String icon, Function function) {
  return FlatButton(
      shape: CircleBorder(),
      onPressed: () => function(),
      child: Image.asset(
        'assets/Registration/${icon}',
        height: 48,
        width: 48,
      ));
}
