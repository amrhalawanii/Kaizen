import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Pages/Card/Card_Page_2.dart';
import 'package:kaizen/Pages/List/ViewList_Page.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';

class AllCardsPage extends StatefulWidget {
  const AllCardsPage({Key? key}) : super(key: key);

  @override
  _AllCardsPageState createState() => _AllCardsPageState();
}

class _AllCardsPageState extends State<AllCardsPage> {
  List<KaizenCard> allKaizenCards = [];
  getAllCards() async {
    allKaizenCards.clear();
    kaizenLists!.forEach((list) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(activeUser!.userId)
          .collection('lists')
          .doc(list.listId)
          .collection("cards")
          .get()
          .then((snapshot) {
        print(snapshot.docs.length);
        snapshot.docs.forEach((element) {
          setState(() {
            allKaizenCards.add(KaizenCard(
                element.data()['cardId'],
                element.data()['cardTitle'],
                element.data()["cardDescription"]));
          });
        });
        // print(kaizenLists);
      });
    });
  }

  @override
  void initState() {
    getAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All Cards",
          style: GoogleFonts.lato(),
        ),
      ),
      body: HomePageBackground(
          child: Container(
        child: allKaizenCards.isEmpty
            ? ShowCircularProgressIndicator()
            : AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(Device.width! / 30),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: allKaizenCards.length,
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
                              Navigator.push(
                                  context,
                                  PageTransitionOpen(ViewCard2(
                                    kaizenCard: allKaizenCards[index],
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
                                  child: Text(
                                allKaizenCards[index].cardTitle,
                                style: GoogleFonts.lato(
                                    color: ConstantColors.purpleExtraDark,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      )),
    );
  }
}
