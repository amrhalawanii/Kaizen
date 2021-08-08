import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';

class HomePageBackground extends StatelessWidget {
  final Widget child;

  const HomePageBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Device.height,
      width: Device.width,
      color: ConstantColors.accentLightGrey,
      child: Stack(
        children: [
          Positioned(
            top: 120,
            right: 0,
            child: Image.asset(
              ConstantImages.backgroundItem1,
              height: Device.height! * 0.55,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(ConstantImages.backgroundItem2,
                height: Device.height! * 0.55),
          ),
          child
        ],
      ),
    );
  }
}
