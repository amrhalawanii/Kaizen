import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Configuration/SharedPreferencesMethods.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/ShowMessages.dart';
import 'package:kaizen/Helpers/User.dart';
import 'package:kaizen/Pages/List/SelectList_page.dart';

class AuthServices {
  //------------------------------------------------------------------------
  //-------------------------------- Sign In -------------------------------
  //------------------------------------------------------------------------
  signIn(BuildContext context, String email, String password) async {
    KaizenUser? kaizenUser;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((fireUser) async {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(fireUser.user!.uid)
          .get()
          .then((snapshot) {
        activeUser = KaizenUser(snapshot.data()!['userId'].toString(),
            snapshot.data()!['username'].toString(), email);
        print(activeUser!.userId + activeUser!.email + activeUser!.username);
      });
      SharedPreferencesMethods.saveUserSharedPreferences(activeUser!);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SelectListPage()));
    }).catchError((e, stackTrace) {
      switch (e.code.toString()) {
        case 'user-not-found':
          ShowMessage().showErrorDialog(
              context, "Invalid Email", "No user found for that email.");
          break;
        case 'wrong-password':
          ShowMessage().showErrorDialog(context, "Invalid Password",
              "Wrong password provided for that user.");
          break;
        default:
          ShowMessage()
              .showErrorDialog(context, "Error", "${e.message.toString()}");
      }
    });
  }

  //------------------------------------------------------------------------
  //--------------------------- Create User Account ------------------------
  //------------------------------------------------------------------------
  createAccount(BuildContext context, String email, String username,
      String password) async {
    print("We Here");
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((fireUser) async {
      print("Account Created");

      await FirebaseFirestore.instance
          .collection("user")
          .doc(fireUser.user!.uid)
          .set({
        "userId": fireUser.user!.uid,
        "username": username,
        "email": email
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        activeUser = KaizenUser(fireUser.user!.uid, username, email);
        ShowMessage().showAchievementView(
            context,
            "Welcome To Kaizen",
            "Your account has been created successfully !",
            Icon(
              Icons.check_circle_outlined,
              color: Colors.white,
            ));
        SharedPreferencesMethods.saveUserSharedPreferences(activeUser!);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SelectListPage()));
      });
    }).catchError((e, stackTrace) {
      switch (e.code.toString()) {
        case 'weak-password':
          ShowMessage().showErrorDialog(
              context, "Weak Password", "The password provided is too weak.");
          break;
        case 'email-already-in-use':
          ShowMessage().showErrorDialog(context, "Invalid Email",
              "The account already exists for that email.");
          break;
        default:
          ShowMessage()
              .showErrorDialog(context, "Error", "${e.message.toString()}");
      }
    });
  }
}
