import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemDropDownTax extends StatelessWidget {
  String listItemSelected = 'Apply tax to new items';
  final List<String> listItem = ['Apply tax to new items', 'Item 2', 'Item 3'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        isExpanded: true,
        value: listItemSelected,
        iconSize: 30,
        icon: (null),
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),
        hint: Text('Select State'),
        onChanged: (newValue) {
          this.listItemSelected = newValue.toString();
        },
        items: listItem.map((item) {
          return new DropdownMenuItem(
            child: new Text(item),
            value: item,
          );
        }).toList(),
      ),
    );
  }
}
