import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';

Widget AddCardFloatingButton(BuildContext context, MaterialPageRoute route) {
  return FloatingActionButton(
    backgroundColor: Color(0xFF280B6F),
    child: Icon(
      Icons.add,
      color: Colors.white,
    ),
    onPressed: () {
      Navigator.of(context).push(route);
    },
  );
}
