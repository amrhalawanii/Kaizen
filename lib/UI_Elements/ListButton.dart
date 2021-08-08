import 'package:flutter/material.dart';
import 'package:kaizen/Helpers/Constants.dart';
import 'package:kaizen/Helpers/KaizenList.dart';

class ListButton extends StatefulWidget {
  final int index;

  const ListButton({Key? key, required this.index}) : super(key: key);

  @override
  _ListButtonState createState() => _ListButtonState();
}

class _ListButtonState extends State<ListButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        height: Device.height! * 0.07,
        width: Device.width! / 1.75,
        // color: Colors.black,
        child: FlatButton(
          splashColor: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                // margin: EdgeInsets.only(top:4, bottom: 4),
                // width: 165,
                width: Device.width! * 0.4,
                // color: Colors.blue,
                child: Text(
                  kaizenLists![widget.index].listTitle,
                  style: TextStyle(
                      color: kaizenLists![widget.index].isSelected
                          ? ConstantColors.accentLightGrey
                          : ConstantColors.purpleDark,
                      // fontSize:20
                      fontSize: 16),
                ),
              ),
              kaizenLists![widget.index].isSelected ? SelectedIcon() : AddIcon()
            ],
          ),
          color: kaizenLists![widget.index].isSelected
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              side: BorderSide(
                color: kaizenLists![widget.index].isSelected
                    ? Colors.transparent
                    : ConstantColors.purpleDark,
              )),
          onPressed: () {
            setState(() {
              kaizenLists![widget.index].isSelected =
                  !kaizenLists![widget.index].isSelected;
            });
            if (kaizenLists![widget.index].isSelected) {
              selectedList.add(kaizenLists![widget.index]);
            } else {
              selectedList.remove(kaizenLists![widget.index]);
            }
            // setState(() {
            //   widget.item.isSelected = !widget.item.isSelected;
            // });
          },
        ),
      ),
    );
  }
}

class SelectedIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            color: ConstantColors.accentLightGrey, shape: BoxShape.circle),
        child: Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ));
  }
}

class AddIcon extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ConstantColors.purpleDark)),
        child: Icon(
          Icons.add,
          color: ConstantColors.purpleDark,
        ));
  }
}
