import 'package:flutter/material.dart';

const Color kDefaultGreen = Color(0xff30B700);
const Color kDefaultBackgroundColor = Color(0xffF4F4F4);
const Color kBlackColor = Color(0xff000000);
const Color kAccentColor = Color(0xff7A7A7A);
const Color kIconColor = Color(0xff707070);

const Color kBorderColor = Color(0xffE0E0E0);
const EdgeInsets kScreenMargin = EdgeInsets.symmetric(horizontal: 16);

const TextStyle kSemiLargeText = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

const TextStyle kAppBarText = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const BoxShadow kBoxShadow = BoxShadow(
  color: Color(0x55d3d3d3),
  spreadRadius: 1,
  blurRadius: 5,
  offset: Offset(0, 6), // changes position of shadow
);

BoxDecoration kCardDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [kBoxShadow],
  borderRadius: BorderRadius.circular(5),
);

var boxHeight = SizedBox(
  height: 10,
);
var boxWidth = SizedBox(
  width: 20,
);

const divider = Divider(thickness: 1);

class LabelText extends StatelessWidget {
  const LabelText({
    Key? key,
    required this.labelName,
  }) : super(key: key);

  final String labelName;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        labelName,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
