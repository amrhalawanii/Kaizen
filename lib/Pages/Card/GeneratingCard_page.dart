import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Pages/Card/Card_Page.dart';
import 'package:kaizen/Pages/Card/FullCard_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';

class GenerateCardPage extends StatefulWidget {
  const GenerateCardPage({Key? key}) : super(key: key);

  @override
  _GenerateCardPageState createState() => _GenerateCardPageState();
}

class _GenerateCardPageState extends State<GenerateCardPage> {
  generateCard() async {
    Random random = new Random();
    int randomNumber = random.nextInt(selectedList.length);
    print(selectedList[randomNumber].listTitle);
    getCards(randomNumber);
  }

  getCards(int number) async {
    Random random = new Random();
    List<KaizenCard> kaizenCards = [];
    await FirebaseFirestore.instance
        .collection('user')
        .doc(activeUser!.userId)
        .collection('lists')
        .doc(selectedList[number].listId)
        .collection("cards")
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        kaizenCards.add(KaizenCard(element.data()['cardId'],
            element.data()['cardTitle'], element.data()['cardDescription']));
      });
      print(snapshot.docs.length);
    }).then((value) {
      int randomNumber = random.nextInt(kaizenCards.length);
      print("The random kaizen card is card " +
          kaizenCards[randomNumber].cardTitle);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => CardPage(
                kaizenCard: kaizenCards[randomNumber],
                kaizenList: selectedList[number],
              )));
    });
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      generateCard();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageBackground(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              ConstantImages.randomCard,
              height: Device.height! * 0.3,
            ),
            Text(
              "Getting a random card...",
              style: GoogleFonts.lato(
                  fontSize: 20,
                  color: ConstantColors.purpleDark,
                  fontWeight: FontWeight.w600),
            ),
            SpinKitWave(
              size: 60.0,
              color: ConstantColors.purpleDark,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      )),
    );
  }
}
