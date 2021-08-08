import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/UI_Elements/Background.dart';

class ViewCard2 extends StatefulWidget {
  final KaizenCard kaizenCard;
  const ViewCard2({Key? key, required this.kaizenCard}) : super(key: key);

  @override
  _ViewCard2State createState() => _ViewCard2State();
}

class _ViewCard2State extends State<ViewCard2> {
  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: ConstantColors.purpleExtraDark,
          ),
        ),
      ),
    );
  }

  _renderContent(context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1000,
        onFlipDone: (status) {
          // print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: ConstantColors.purpleExtraDark,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.kaizenCard.cardTitle,
                  style: GoogleFonts.lato(
                      color: ConstantColors.accentLightGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text('Click here to flip back',
                  style: GoogleFonts.lato(
                    color: ConstantColors.accentLightGrey.withOpacity(0.5),
                  )),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: ConstantColors.purpleExtraDark,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.kaizenCard.cardDescription,
                          style: GoogleFonts.lato(
                            color: ConstantColors.accentLightGrey,
                            fontSize: 16,
                          )),
                      Text('Click here to flip front',
                          style: GoogleFonts.lato(
                            color:
                                ConstantColors.accentLightGrey.withOpacity(0.5),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePageBackground(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // Positioned(
            //     top: 20,
            //     left: 10,
            //     child: IconButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       icon: Icon(
            //         Icons.arrow_back_ios_rounded,
            //         color: ConstantColors.purpleExtraDark,
            //       ),
            //     )),
            // _renderBg(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _renderAppBar(context),
                Expanded(
                  flex: 4,
                  child: _renderContent(context),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
