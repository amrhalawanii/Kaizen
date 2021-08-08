import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenCard.dart';
import 'package:kaizen/Helpers/KaizenList.dart';
import 'package:kaizen/UI_Elements/AddCardButton.dart';
import 'package:kaizen/UI_Elements/Background.dart';
import 'package:slimy_card/slimy_card.dart';

class CardPage extends StatefulWidget {
  final KaizenCard kaizenCard;
  final KaizenList kaizenList;

  const CardPage({Key? key, required this.kaizenCard, required this.kaizenList})
      : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.accentLightGrey,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.kaizenList.listTitle,
          style: GoogleFonts.lato(
              color: ConstantColors.purpleDark,
              fontSize: 20,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: ConstantColors.purpleDark,
            )),
      ),
      body: HomePageBackground(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlimyCard(
              color: ConstantColors.purpleDark,
              topCardHeight: 180,
              topCardWidget: TopCardWidget(widget.kaizenCard.cardTitle),
              bottomCardHeight: 450,
              bottomCardWidget:
                  BottomCardWidget(widget.kaizenCard.cardDescription),
            ),
          ],
        ),
      )),
    );
  }
}

Widget TopCardWidget(String title) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

Widget BottomCardWidget(String description) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Text(
          description
          //         """Having the ability to show up and play full out all the way till the finish line is what it takes to be great!

          // 5 Stages Of Accelerated Learning:

          // 1. Unconscious Incompetence
          // You don't know you don't know how to do something

          // 2. Conscious Incompetence
          // You know you don't know

          // 3. Conscious Competence
          // You are competent you can do something, but it takes your conscious attention, you have to think about it while you are doing it

          // 4. Unconscious Competence
          // When you practice something so much you become unconscious about it.
          // It becomes second nature to you
          // like driving a car, you don't think about driving

          // The key to  get from  conscious competence to un conscious competence: CONSISTENCY and practice
          // It takes effort but not as much as you think

          // 5. Mastery
          // The best skill to master in the 21st century is the skill to activate your super brain, learn faster, be better, think faster, improve brain.

          // The master becomes the master of the fundamentals

          // Pareto Principle
          // 80 20 rules: 20 Percent of the effort, gives you 80 percent of the work

          // If Knowledge is power -> Learning is your super power
          // Read the 7 habits of highly effective people
          // If someone has decades of experience in something and they put it in a book, you can install decades of experience into your brain in a couple of days.

          // 7 Habits Of Highly Effective People:

          // 1. Be proactive
          //  proactive is another word to responsibility

          // 2. Begin with the end in mind
          // A goal, a destination

          // 3. Put first things first
          // "Say no to good, so you can say yes to great"
          // Do what matters first

          // 4. Think win-win
          // Always win

          // 5. Seek first to understand, then to be understood
          // No one cares how much you know till they know how much you care.

          // Read: Understanding understanding

          // 6. Synergize
          // Together everyone achieves more
          // JOIN WITH PEOPLE
          // use your connections to empower your self

          // 7. Sharpen the saw

          // 8. Find your voice, and help others to find theirs

          // "Your mess can become your message"

          // Know who you are, then be who you are

          // Self awareness is a superpower

          // If an egg is broken from an outside force live ends, but if it is broken from an inside force
          // live begins.
          // """
          ,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}
