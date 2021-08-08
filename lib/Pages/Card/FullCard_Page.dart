import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Pages/Card/AddCard_Page.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';

class FullCardPage extends StatefulWidget {
  const FullCardPage({Key? key}) : super(key: key);

  @override
  _FullCardPageState createState() => _FullCardPageState();
}

class _FullCardPageState extends State<FullCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCardFloatingButton(
          context, MaterialPageRoute(builder: (context) => AddCardPage())),
      appBar: AppBar(
        backgroundColor: ConstantColors.accentLightGrey,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xFF280B6F),
              size: 35,
            )),
      ),
      body: HomePageBackground(
          child: Center(
        child: Container(
          width: Device.width! * 0.85,
          height: Device.height! * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0xc4ffffff),
            boxShadow: [
              BoxShadow(
                color: const Color(0x20000000),
                offset: Offset(4, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Title",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        color: ConstantColors.purpleExtraDark,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0, 0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Description:",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          color: ConstantColors.purpleExtraDark,
                          fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                  width: Device.width,
                  height: Device.height! * 0.63,

                  // color: Colors.black,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        """orem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
                        Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam""",
                        // "Just do it",
                        style: GoogleFonts.lato(
                            fontSize: 16,
                            color: ConstantColors.purpleExtraDark),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
