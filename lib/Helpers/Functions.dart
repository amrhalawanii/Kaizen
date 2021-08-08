import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Helpers/User.dart';

checkFields(GlobalKey<FormState> _formKey) {
  final form = _formKey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}

AddList(BuildContext context, KaizenList list) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .doc(list.listId)
      .set({
    'listId': list.listId,
    'listTitle': list.listTitle,
    'listDescription': list.listDescription,
    'numberOfCards': 0
  }).catchError((e) {
    ShowMessage().showErrorDialog(context, "Error", e.toString());
  });

  //Access Firebase and save List
}

AddCard(BuildContext context, KaizenList list, KaizenCard card) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .doc(list.listId)
      .collection("cards")
      .doc(card.cardId)
      .set({
    'cardId': card.cardId,
    'cardTitle': card.cardTitle,
    'cardDescription': card.cardDescription
  }).catchError((e) {
    ShowMessage().showErrorDialog(context, "Error", e.toString());
  });

  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .doc(list.listId)
      .update({"numberOfCards": FieldValue.increment(1)});
}

updateCard(BuildContext context, KaizenList list, KaizenCard card) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .doc(list.listId)
      .collection("cards")
      .doc(card.cardId)
      .update({
    'cardId': card.cardId,
    'cardTitle': card.cardTitle,
    'cardDescription': card.cardDescription
  }).catchError((e) {
    ShowMessage().showErrorDialog(context, "Error", e.toString());
  });
}

updateList(BuildContext context, KaizenList list) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .doc(list.listId)
      .update({
    'listId': list.listId,
    'listTitle': list.listTitle,
    'listDescription': list.listDescription,
    'numberOfCards': list.numberOfCards
  }).catchError((e) {
    ShowMessage().showErrorDialog(context, "Error", e.toString());
  });
}

getLists() async {
  kaizenLists!.clear();
  await FirebaseFirestore.instance
      .collection('user')
      .doc(activeUser!.userId)
      .collection('lists')
      .get()
      .then((snapshot) {
    print(snapshot.docs.length);
    snapshot.docs.forEach((element) {
      print(element.data()['listTitle']);

      kaizenLists!.add(KaizenList(
        element.data()['listTitle'],
        element.data()['listDescription'],
        element.data()['listId'],
        false,
        element.data()['numberOfCards'],
      ));
    });
    // print(kaizenLists);
  });
}

getUserInfo(String id) async {
  await FirebaseFirestore.instance
      .collection('user')
      .doc(id)
      .get()
      .then((snapshot) {
    print(snapshot.data().toString());
    activeUser = KaizenUser(
        snapshot.data()!['userId'].toString(),
        snapshot.data()!['username'].toString(),
        snapshot.data()!['email'].toString());
  });
}

sendFeedback(
    BuildContext context, String id, String title, String message) async {
  await FirebaseFirestore.instance.collection('feedback').doc(id).set({
    'messageId': id,
    'senderId': activeUser!.userId,
    'senderUsername': activeUser!.username,
    "title": title,
    "message": message
  }).catchError((e) {
    ShowMessage().showErrorDialog(
        context, "Unable to send message", e.message.toString());
  });
}
