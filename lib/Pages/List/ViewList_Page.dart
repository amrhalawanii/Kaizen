import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/Functions.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/PageTransitions.dart';
import 'package:kaizen/Pages/Card/AddFirstCard_Page.dart';
import 'package:kaizen/Pages/Card/Card_Page_2.dart';
import 'package:kaizen/Pages/Card/EditCard_Page.dart';
import 'package:kaizen/Pages/List/AddList_page.dart';
import 'package:kaizen/Pages/List/EditList_page.dart';
import 'package:kaizen/Pages/List/EditLists.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:kaizen/UI_Elements/Circular_progrss.dart';

class ViewListPage extends StatefulWidget {
  final KaizenList kaizenList;
  const ViewListPage({Key? key, required this.kaizenList}) : super(key: key);

  @override
  _ViewListPageState createState() => _ViewListPageState();
}

class _ViewListPageState extends State<ViewListPage> {
  List<KaizenCard> kaizenCards = [];
  getAllCards() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(activeUser!.userId)
        .collection('lists')
        .doc(widget.kaizenList.listId)
        .collection("cards")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        print(element.data().toString());
        setState(() {
          kaizenCards.add(KaizenCard(element.data()['cardId'],
              element.data()['cardTitle'], element.data()['cardDescription']));
        });
      });
      print(snapshot.docs.length);
    });
  }

  DeleteList() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(activeUser!.userId)
        .collection('lists')
        .doc(widget.kaizenList.listId)
        .delete()
        .then((value) async {
      selectedList.clear();
      kaizenLists!.clear();
      getLists().then((v) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => EditListsPage()));
      });
    });
  }

  editCard() async {}
  deleteCard(KaizenCard kaizenCard) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(activeUser!.userId)
        .collection('lists')
        .doc(widget.kaizenList.listId)
        .collection("cards")
        .doc(kaizenCard.cardId)
        .delete()
        .then((value) async {
      kaizenCards.remove(kaizenCard);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(activeUser!.userId)
          .collection('lists')
          .doc(widget.kaizenList.listId)
          .update({"numberOfCards": FieldValue.increment(-1)});
      getLists();
      kaizenCards.clear();
      getAllCards();
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    getAllCards();
    super.initState();
  }

  goToEditPage() {
    Navigator.push(
        context,
        PageTransition(EditListPage(
          kaizenList: widget.kaizenList,
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCardFloatingButton(
          context,
          MaterialPageRoute(
              builder: (context) => AddFirstCardPage(
                    kaizenlist: widget.kaizenList,
                  ))),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // brightness: Brightness.light,
        title: Text(
          widget.kaizenList.listTitle,
          style: GoogleFonts.lato(
              color: ConstantColors.purpleExtraDark, fontSize: 14),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => EditListsPage()));
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: ConstantColors.purpleExtraDark,
              size: 30,
            )),
        actions: [
          PopupMenuButton(
              icon: Icon(
                Icons.more_vert_rounded,
                color: ConstantColors.purpleExtraDark,
              ),
              onSelected: (value) {
                if (value == 1)
                  goToEditPage();
                else if (value == 2) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("Delete List"),
                          content:
                              Text("Are you sure you want to delete list?"),
                          actions: [
                            CupertinoDialogAction(
                                onPressed: () {
                                  DeleteList();
                                },
                                child: Text("Yes")),
                            CupertinoDialogAction(child: Text("Cancel")),
                          ],
                        );
                      });
                }
              },
              shape: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ConstantColors.purpleExtraDark, width: 2)),
              // color: ConstantColors.purpleExtraDark,
              elevation: 20.0,
              itemBuilder: (context) => <PopupMenuItem>[
                    PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: ConstantColors.purpleExtraDark,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Edit List",
                              style: GoogleFonts.lato(
                                  color: ConstantColors.purpleExtraDark),
                            ),
                          ],
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              color: ConstantColors.purpleExtraDark,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Delete List",
                              style: GoogleFonts.lato(
                                  color: ConstantColors.purpleExtraDark),
                            ),
                          ],
                        ))
                  ])
        ],
      ),
      body: HomePageBackground(
        child: kaizenCards.isEmpty
            ? ShowCircularProgressIndicator()
            : kaizenCards.length == 0
                ? Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.card_membership,
                            color: Colors.black54,
                            size: 100,
                          ),
                          SizedBox(height: 20),
                          Text(
                            "You don't have any Cards yet",
                            style: GoogleFonts.lato(
                                fontSize: 24, color: Colors.black54),
                          ),
                          SizedBox(height: 20),
                          OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(AddFirstCardPage(
                                      kaizenlist: widget.kaizenList,
                                    )));
                              },
                              child: Text(
                                "Add Card",
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
                      itemCount: kaizenCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            verticalOffset: -850,
                            horizontalOffset: -300,
                            child: ScaleAnimation(
                              duration: Duration(milliseconds: 1500),
                              curve: Curves.fastLinearToSlowEaseIn,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(ViewCard2(
                                        kaizenCard: kaizenCards[index],
                                      )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: Device.width! / 20),
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
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                PageTransition(EditCardPage(
                                                    kaizenCard:
                                                        kaizenCards[index],
                                                    kaizenList:
                                                        widget.kaizenList)));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color:
                                                ConstantColors.purpleExtraDark,
                                          )),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            kaizenCards[index].cardTitle,
                                            style: GoogleFonts.lato(
                                                color: ConstantColors
                                                    .purpleExtraDark,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    title: Text("Delete Card"),
                                                    content: Text(
                                                        "Are you sure you want to delete card?"),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                          onPressed: () {
                                                            deleteCard(
                                                                kaizenCards[
                                                                    index]);
                                                          },
                                                          child: Text("Yes")),
                                                      CupertinoDialogAction(
                                                          child:
                                                              Text("Cancel")),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color:
                                                ConstantColors.purpleExtraDark,
                                          )),
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
