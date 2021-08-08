import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/SplashPage/Splash_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return KaizenApp();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}

class KaizenApp extends StatelessWidget {
  const KaizenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KAIZEN',
      theme: ThemeData(
        primaryColor: const Color(0xFF6730EC),
      ),
      home: SplashPage(),
    );
  }
}
