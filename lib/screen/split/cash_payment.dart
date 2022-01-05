import 'package:flutter/material.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/controller/split_controller.dart';
import 'package:pos/screen/split/splitoption.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class CashPayment extends StatelessWidget {
  CashPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _pay = Provider.of<SplitController>(context);
    var _itemsCon = Provider.of<ItemsController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Cash Payment',
          style: kAppBarText,
        ),
        actions: [
          GestureDetector(
            child: const Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: Center(
                  child: Text(
                'SPLIT',
                style: TextStyle(
                    color: Color(0xFF30B700),
                    fontFamily: 'RobotoRegular',
                    fontSize: 16.0),
              )),
            ),
            onTap: () {
              _pay.splitPayment(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: _itemsCon.ticketList.isNotEmpty
                    ? Text(
                        _itemsCon.value.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        'Rs. 0.0',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            Center(
                child: _itemsCon.value > 0
                    ? const Text('Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                        ))
                    : const SizedBox()),
            const SizedBox(
              height: 40,
            ),
            const Text('Cash Received',
                style: TextStyle(fontSize: 14, fontFamily: 'RobotoRegular')),
            AddTextField(
              hintText: 'amount',
              textEditingController: _itemsCon.cashReceived,
            ),
            // _pay.cashReceived > 0.0
            //     ?    SplitTextFormField(
            //             hintText: 'Enter amount',
            //             textEditingController: _itemsCon.cashReceived)
            //     : Text(_pay.returnChange.toString(),
            //         style: const TextStyle(
            //             fontSize: 14, fontFamily: 'RobotoRegular')),
            // const Padding(
            //   padding: EdgeInsets.only(top: 8.0),
            //   child: Divider(
            //     color: Color(0xFFE0E0E0),
            //     thickness: 1.5,
            //   ),
            // ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: PayButton(
                color: kDefaultGreen,
                text: const Text('Confirm', style: kSemiLargeText),
                onPress: () {
                  if (_itemsCon.cashReceived.text.isNotEmpty &&
                      _itemsCon.ticketList.isNotEmpty) {
                    _itemsCon.performTransaction(context);
                    _itemsCon.cashReceived.clear();
                  } else
                    print('amount not defined or items not added');
                },
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
