import 'package:flutter/material.dart';
import 'package:pos/controller/ticket.dart';
import 'refundscreen.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class ReceiptDetails extends StatelessWidget {
  const ReceiptDetails({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    var _reciept = Provider.of<TicketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('#100-00${index + 1}'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          RecieptMenuItems(),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        children: [
          Text(
            "Customer",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_reciept.openTicketList[index].name}',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 14,
                ),
              ),
              Text(
                'Dine in',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                'Table no.${index + 1}',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          divider,
          SizedBox(height: 16),
          Text(
            "Items Ordered",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Column(
            children: List.generate(
              _reciept.itemsOrdered.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${_reciept.itemsOrdered[index].itemName}',
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'x ${_reciept.itemsOrdered[index].itemQuantity}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(
                      '${_reciept.itemsOrdered[index].itemRate}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          divider,
          CustomRow(
            label: 'Total',
            trailing: 'Rs 3000',
          ),
          CustomRow(
            label: 'Discount',
            trailing: '-',
          ),
          CustomRow(
            label: 'Vat',
            trailing: '13%',
          ),
          CustomRow(
            label: 'Service Charge',
            trailing: '10%',
          ),
          CustomRow(
            label: 'Grand Total',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            trailing: 'Rs 1832.7',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: divider,
          ),
          CustomRow(
            label: 'Cashier',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          CustomRow(
            label: 'Asim Poudel',
            trailing: 'Payment Mode: Cash',
          ),
          CustomRow(
            label: 'Counter: POS12',
            trailing: 'Date: 21/06/2021',
          ),
        ],
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    Key? key,
    required this.label,
    this.trailing,
    this.fontSize,
    this.fontWeight,
  }) : super(key: key);
  final String label;
  final String? trailing;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: fontSize ?? 14,
                fontWeight: fontWeight ?? FontWeight.w400),
          ),
          trailing != null
              ? Text(
                  '$trailing',
                  style: TextStyle(
                      fontSize: fontSize ?? 14,
                      fontWeight: fontWeight ?? FontWeight.w400),
                )
              : Text(''),
        ],
      ),
    );
  }
}

class RecieptMenuItems extends StatelessWidget {
  const RecieptMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: GestureDetector(
            child: Text(
              'Refund',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text(
            'Send receipt',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        print('Refund pressed');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RefundScreen(),
          ),
        );
        break;
      case 1:
        print('Send receipt pressed');
        break;
    }
  }
}
