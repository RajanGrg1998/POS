import 'package:flutter/material.dart';
import 'package:pos/controller/split_controller.dart';
import 'package:provider/provider.dart';
import 'splitoption.dart';

class Split extends StatelessWidget {
  const Split({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pay = Provider.of<SplitController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Remaining ' + _pay.totalAmount.toString(),
          style: const TextStyle(
              color: Colors.black, fontFamily: 'RobotoRegular', fontSize: 16.0),
        ),
      ),
      body: SplitOptionBody(),
    );
  }
}
