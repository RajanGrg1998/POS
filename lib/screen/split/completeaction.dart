import 'package:flutter/material.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

import '../homepage.dart';

class CompleteActionPayment extends StatelessWidget {
  const CompleteActionPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _itemsCon = Provider.of<ItemsController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Cash Payment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width * 0.66,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff707070),
                      blurRadius: 1.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                // height: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomColumn(
                        rate: '${_itemsCon.value}',
                        title: 'Total Amount',
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Color(0xffE0E0E0),
                    ),
                    Expanded(
                      child: CustomColumn(
                        rate: '${_itemsCon.returnChange}',
                        title: 'Change',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.email),
                boxWidth,
                Expanded(
                  child: AddTextField(hintText: 'ok.123@gmail.com'),
                ),
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                width: 184,
                height: 37,
                child: PrimaryButton(
                  title: 'Complete Payment',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Homepage(),
                        ),
                        (route) => false);

                    // _itemsCon.removeAll();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    Key? key,
    required this.rate,
    required this.title,
  }) : super(key: key);

  final String rate;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          rate,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 7),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
