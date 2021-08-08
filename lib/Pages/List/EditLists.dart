// import this Package in pubspec.yaml file
// dependencies:
//
//   flutter_staggered_animations: ^1.0.0

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/List/AddList_page.dart';
import 'package:kaizen/Pages/List/ViewList_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';

class EditListsPage extends StatefulWidget {
  const EditListsPage({Key? key}) : super(key: key);

  @override
  _EditListsPageState createState() => _EditListsPageState();
}

class _EditListsPageState extends State<EditListsPage> {
  @override
  void initState() {
    print(kaizenLists.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Lists",
          style: GoogleFonts.lato(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: ConstantColors.accentLightGrey,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, PageTransition(AddListPage()));
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: ConstantColors.accentLightGrey,
                size: 30,
              )),
        ],
      ),
      body: HomePageBackground(
        child: kaizenLists!.length == 0
            ? Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        color: Colors.black54,
                        size: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "You don't have any lists yet",
                        style: GoogleFonts.lato(
                            fontSize: 24, color: Colors.black54),
                      ),
                      SizedBox(height: 20),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context, PageTransition(AddListPage()));
                          },
                          child: Text(
                            "Add List",
                            style: GoogleFonts.lato(
                                fontSize: 18, color: Colors.black54),
                          ))
                    ],
                  ),
                ),
              )
            : AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(Device.width! / 30),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: kaizenLists!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      delay: Duration(milliseconds: 100),
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        verticalOffset: -250,
                        child: ScaleAnimation(
                          duration: Duration(milliseconds: 1500),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransitionOpen(ViewListPage(
                                    kaizenList: kaizenLists![index],
                                  )));
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(bottom: Device.width! / 20),
                              height: Device.width! / 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    kaizenLists![index].listTitle,
                                    style: GoogleFonts.lato(
                                        color: ConstantColors.purpleExtraDark,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${kaizenLists![index].numberOfCards} Cards",
                                    style: GoogleFonts.lato(
                                      color: ConstantColors.purpleExtraDark,
                                    ),
                                  )
                                ],
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
