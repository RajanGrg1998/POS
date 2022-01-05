import 'package:flutter/material.dart';

class MobileTile extends StatelessWidget {
  final String taxName;
  final String? charge;

  MobileTile({required this.taxName, this.charge});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      title: Text(taxName),
      trailing: Text(charge! + '%'),
    );
  }
}
