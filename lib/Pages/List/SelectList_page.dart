import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';
import 'package:kaizen/Pages/Card/GeneratingCard_page.dart';
import 'package:kaizen/Pages/List/AddList_page.dart';
import 'package:kaizen/Pages/Sidebar/sidebar.dart';
import 'package:kaizen/Pages/SplashPage/Splash_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';
import 'package:kaizen/UI_Elements/ListButton.dart';

class SelectListPage extends StatefulWidget {
  @override
  _SelectListPageState createState() => _SelectListPageState();
}

class _SelectListPageState extends State<SelectListPage> {
  List<String> litems = ["1", "2", "Third", "4"];

  List<KaizenList> kaizenListItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: AddCardFloatingButton(
            context, MaterialPageRoute(builder: (context) => AddCardPage())),
        body: Stack(
          children: [HomePage(), SideBar()],
        ));
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfLists = 0;
  // List<KaizenList>? kaizenLists = [];
  getLists() async {
    print("We getting list ");
    print("User ID" + activeUser!.userId.toString());
    await FirebaseFirestore.instance
        .collection('user')
        .doc(activeUser!.userId)
        .collection('lists')
        .get()
        .then((snapshot) {
      setState(() {
        numberOfLists = snapshot.docs.length;
      });
      print(snapshot.docs.length);
      snapshot.docs.forEach((element) {
        print(element.data()['listTitle']);

        setState(() {
          kaizenLists!.add(KaizenList(
            element.data()['listTitle'],
            element.data()['listDescription'],
            element.data()['listId'],
            false,
            element.data()['numberOfCards'],
          ));
        });
      });
      // print(kaizenLists);
    }).catchError((e) {
      ShowMessage().showErrorDialog(context, "Error", e.message.toString());
    });
  }

  @override
  void initState() {
    kaizenLists!.clear();
    selectedList.clear();
    getLists();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Device.width = MediaQuery.of(context).size.width;
    Device.height = MediaQuery.of(context).size.height;
    List<String>? list = ["List 1", "List 2", "List 3", "List 4", "List 5"];
    return Container(
        child: HomePageBackground(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            //----------------------------------------------------------------
            //----------------------------- Image ----------------------------
            //----------------------------------------------------------------
            Container(
              height: Device.height! * 0.2,
              child: Image.asset(ConstantImages.selectList),
            ),
            SizedBox(
              height: 20,
            ),
            //----------------------------------------------------------------
            //-------------------------- Select List  ------------------------
            //----------------------------------------------------------------
            Text("Select List",
                style: GoogleFonts.lato(
                    fontSize: 28,
                    color: ConstantColors.purpleDark,
                    fontWeight: FontWeight.bold)),

            //----------------------------------------------------------------
            //----------------------------- List -----------------------------
            //----------------------------------------------------------------
            kaizenLists == null
                ? ShowCircularProgressIndicator()
                : kaizenLists!.length == 0
                    ? Container(
                        height: 150,
                        child: Center(
                          child: Text(
                            "Your KAIZEN list is still empty",
                            style: GoogleFonts.lato(
                                fontSize: 18.0, color: Colors.grey[600]),
                          ),
                        ),
                      )
                    : Container(
                        // color: Colors.red,
                        width: Device.width! * 0.75,
                        height: 350,
                        child: ListView.builder(
                            itemCount: kaizenLists!.length,
                            itemBuilder: (context, index) {
                              return ListButton(
                                index: index,
                              );
                            }),
                      ),
            //----------------------------------------------------------------
            //----------------------- Add List Button ------------------------
            //----------------------------------------------------------------
            InkWell(
              onTap: () {
                // Navigator.push(context, PageTransition(AddCardPage()));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddListPage()));
              },
              child: Text(
                "Add New List",
                style: GoogleFonts.aBeeZee(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.purpleDark,
                    decoration: TextDecoration.underline),
              ),
            ),
            Spacer(),
            //----------------------------------------------------------------
            //----------------------- Continue Button ------------------------
            //----------------------------------------------------------------
            Container(
                height: 65,
                width: Device.width! * 0.75,
                child: OutlinedButton(
                  onPressed: () {
                    print(selectedList.length.toString() + " Lists Selected");

                    if (selectedList.length > 0)
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GenerateCardPage()));
                  },
                  child: Text(
                    "CONTINUE",
                    style: GoogleFonts.lato(
                        letterSpacing: 1,
                        fontSize: 16,
                        color: ConstantColors.purpleDark,
                        fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: ConstantColors.purpleDark,
                      side: BorderSide(
                          width: 2, color: ConstantColors.purpleDark),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(32),
                          bottomLeft: const Radius.circular(32),
                          bottomRight: const Radius.circular(32),
                        ),
                      )),
                )),
            Spacer(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
