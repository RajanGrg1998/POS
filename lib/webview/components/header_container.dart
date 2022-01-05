import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {
  final String title;
  final List<Widget>? actions;

  const HeaderContainer({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 16, bottom: 10, right: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE0E0E0),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: actions ?? [Container()],
          )
        ],
      ),
    );
  }
}
