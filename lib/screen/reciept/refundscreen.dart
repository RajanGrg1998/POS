import 'package:flutter/material.dart';
import 'package:pos/components/listile.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class RefundScreen extends StatelessWidget {
  const RefundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Refund',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 15, top: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          boxHeight,
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  final items = _controller.itemsOrdered[index];
                  return TileListBox(
                    taxTitle: '${items.itemName}',
                    amount: 'Rs.${items.itemRate}',
                    quantity: items.itemQuantity,
                    isChecked: items.isRefund,
                    chechBoxCallback: (value) {
                      _controller.onSelectRow(index, value!, items);
                    },
                  );
                },
                separatorBuilder: (context, index) => Divider(
                      thickness: 1,
                      indent: 60,
                      endIndent: 15,
                      color: Color(0xffE0E0E0),
                    ),
                itemCount: _controller.itemsOrdered.length),
          ),
          Center(
            child: _controller.itemsRefund.isEmpty
                ? null
                : Container(
                    margin: EdgeInsets.only(bottom: 70),
                    width: 164,
                    height: 37,
                    child: PrimaryButton(
                      title: 'Refund - ${_controller.itemsRefund.length} items',
                      onPressed: () {
                        print(
                            '${_controller.itemsRefund.length} items refunded');
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
