import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Configuration/SharedPreferencesMethods.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Pages/Card/AllCards_Page.dart';
import 'package:kaizen/Pages/List/EditLists.dart';
import 'package:kaizen/Pages/Registration/Registration.dart';
import 'package:kaizen/Pages/Sidebar/contactUs_Page.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  late AnimationController _animationController;
  late StreamController<bool> isSidebarOpenedStreamController;
  late Stream<bool> isSidebarOpenedStream;
  late StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data! ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data! ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: ClipPath(
                  clipper: OvalRightBorderClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1428),
                      border: Border.all(color: const Color(0xFF1C1428)),
                      // color: Colors.pink
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100),
                        //----------------------------------
                        //Header
                        //----------------------------------

                        Container(
                            height: 110,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor,
                                Color(0xFF3B504F)
                              ]),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  AssetImage('assets/amrhalawani.jpeg'),
                            )),
                        SizedBox(height: 10.0),
                        //----------------------------------
                        //Header Title
                        //----------------------------------
                        Column(
                          children: <Widget>[
                            Text(activeUser!.username,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                          ],
                        ),

                        SizedBox(
                          height: 30.0,
                        ),
                        //----------------------------------
                        //Creating List Tiles
                        //----------------------------------

                        DrawerItem(Icons.list, 'All Lists', () {
                          Navigator.push(
                              context, PageTransition(EditListsPage()));
                        }),
                        Divider(
                          color: Colors.white,
                          height: 50,
                          thickness: 0.5,
                        ),
                        DrawerItem(Icons.all_inclusive_rounded, 'All Cards',
                            () {
                          Navigator.push(
                              context, PageTransitionOpen(AllCardsPage()));
                        }),

                        // Divider(
                        //   color: Colors.white,
                        //   height: 50,
                        //   thickness: 0.5,
                        // ),
                        // DrawerItem(Icons.settings, 'Settings', () {}),
                        Divider(
                          color: Colors.white,
                          height: 50,
                          thickness: 0.5,
                        ),
                        DrawerItem(Icons.call, 'Contact Us', () {
                          Navigator.push(
                              context, PageTransitionOpen(ContactUsPage()));
                        }),
                        // Divider(
                        //   color: Colors.white,
                        //   height: 50,
                        //   thickness: 0.5,
                        // ),
                        // DrawerItem(
                        //     Icons.info_outline, 'What is Kaizen?', () {}),
                        Divider(
                          color: Colors.white,
                          height: 50,
                          thickness: 0.5,
                        ),
                        DrawerItem(Icons.exit_to_app, 'Logout', () async {
                          await FirebaseAuth.instance.signOut().then((value) {
                            SharedPreferencesMethods.clearSharedPreferences();
                            Navigator.pushReplacement(
                                context, PageTransition(RegistrationPage()));
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF280B6F),
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width - 40, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(size.width, size.height - (size.height / 4),
        size.width - 40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem(
    this.icon,
    this.title,
    this.function,
  );
  final TextStyle tsyle = TextStyle(
    color: Colors.white60,
    fontSize: 16.0,
    fontFamily: 'Montserrat',
  );
  final String title;
  final IconData icon;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          color: Colors.transparent,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                color: Colors.white60,
              ),
              SizedBox(width: 30),
              Text(
                title,
                style: tsyle,
              ),
            ],
          )),
    );
  }
}

_buildDivider() {
  return Divider(
    color: Colors.grey.shade600,
    height: 50,
  );
}
