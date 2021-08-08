import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Configuration/auth.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/Registration/Signup_page.dart';
import 'package:kaizen/Pages/List/SelectList_page.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:kaizen/UI_Elements/LoginLabel.dart';
import 'package:password_strength/password_strength.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _hidePassword = true;
  bool _isLoading = false;

  String _emailAddress = "";
  String _password = "";
  checkFields() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _submitSignInForm() async {
    FocusScope.of(context).unfocus();
    if (checkFields()) {
      setState(() {
        _isLoading = true;
      });

      AuthServices().signIn(context, _emailAddress, _password).then((v) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
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
                      //------------------------ Login Label -----------------------------
                      //------------------------------------------------------------------
                      Container(
                        // color: Colors.red,
                        width: Device.width! * 0.8,
                        height: Device.height! * 0.16,
                        child: LoginLabel(),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      //------------------------------------------------------------------
                      //------------------------ Login Form ------------------------------
                      //------------------------------------------------------------------

                      Container(
                        // color: Colors.blue[800],
                        width: Device.width! * 0.8,
                        // height: Device.height! * 0.52,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                height: 20,
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
                              //-------------------------- Forgot Password -----------------------
                              //------------------------------------------------------------------
                              Row(
                                children: <Widget>[
                                  Spacer(),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        fontFamily: 'Corbel',
                                        fontSize: 16,
                                        color: const Color(0xffffffff),
                                        letterSpacing: 0.112,
                                        fontWeight: FontWeight.w300,
                                        height: 1.5625,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              //------------------------------------------------------------------
                              //-------------------------- Login Button --------------------------
                              //------------------------------------------------------------------

                              _isLoading
                                  ? ShowCircularProgressIndicator()
                                  : Container(
                                      width: 230,
                                      height: 60,
                                      child: FlatButton(
                                        // onPressed: _trySubmit,
                                        onPressed: _submitSignInForm,
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
                                          'LOGIN',
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: 'Corbel',
                                              color: ConstantColors.purpleDark,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 30,
                              ),

                              //------------------------------------------------------------------
                              //-------------------------- Login With ----------------------------
                              //------------------------------------------------------------------
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text("or login with",
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
                                      LoginWith('loginGoogle.png', () {}),
                                      Platform.isIOS
                                          ? LoginWith('loginApple.png', () {})
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //------------------------------------------------------------------
                      //--------------------------- Sign Up ------------------------------
                      //------------------------------------------------------------------
                      Container(
                        width: Device.width! * 0.8,
                        // color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              "You don't have an account?",
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
                                    builder: (context) => SignupPage()));
                              },
                              child: Text(
                                'Sign Up',
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

Widget LoginWith(String icon, Function function) {
  return FlatButton(
      shape: CircleBorder(),
      onPressed: () => function(),
      child: Image.asset(
        'assets/Registration/${icon}',
        height: 48,
        width: 48,
      ));
}

//Draw a line
class Drawhorizontalline extends CustomPainter {
  late Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-240.0, 0.0), Offset(0.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
