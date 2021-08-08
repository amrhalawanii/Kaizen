import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Helpers/User.dart';
import 'package:kaizen/Pages/List/SelectList_page.dart';
import 'package:kaizen/Pages/Registration/Registration.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 2;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 4), () {
      FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
        if (user == null) {
          setState(() {
            Navigator.pushReplacement(
                context, PageTransition(RegistrationPage()));
          });
        } else {
          print(user.uid);
          await getUserInfo(user.uid).then((v) {
            Navigator.pushReplacement(
                context, PageTransition(SelectListPage()));
          });
        }
      });
      // setState(() {
      //   Navigator.pushReplacement(context, PageTransition(RegistrationPage()));
      // });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _height / _fontSize),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  'KAIZEN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: _width / _containerSize,
                  width: _width / _containerSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SpinKitChasingDots(
                    color: ConstantColors.accentLightGrey,
                  )

                  // child: Text(
                  //   'YOUR APP\'S LOGO',
                  // ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
