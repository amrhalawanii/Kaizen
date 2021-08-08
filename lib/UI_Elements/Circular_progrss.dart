import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';

class ShowCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: ConstantColors.accentLightGrey,
      valueColor: new AlwaysStoppedAnimation<Color>(
        ConstantColors.purpleLight,
      ),
    ));
  }
}
