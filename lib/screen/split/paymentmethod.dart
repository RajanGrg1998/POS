import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';

import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'cash_payment.dart';
import 'completeaction.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _itemsCon = Provider.of<ItemsController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Payment Method',
          style: kAppBarText,
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            heightFactor: 2.5,
            child: CustomColumn(
                rate: _itemsCon.ticketList.isNotEmpty
                    ? 'Rs. ${Provider.of<ItemsController>(context).value}'
                    : 'Rs. 0.0',
                title: 'Total Amount'),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 25),
            children: [
              ListTilePayment(
                title: 'Cash',
                image: 'assets/images/money.png',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CashPayment(),
                    ),
                  );
                },
              ),
              Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              SizedBox(height: 15),
              ListTilePayment(
                title: 'Card',
                image: 'assets/images/credit-cards.png',
                onTap: () {},
              ),
              Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              SizedBox(height: 15),
              ListTilePayment(
                title: 'Online',
                image: 'assets/images/online-payment.png',
                onTap: () {},
              ),
              Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
              SizedBox(height: 15),
              ListTilePayment(
                title: 'Credit',
                image: 'assets/images/credit.png',
                onTap: () {},
              ),
              Divider(
                indent: 30,
                thickness: 1,
                color: Color(0xffE0E0E0),
              ),
            ],
          )
              // // children: [
              // //   ListTile(
              // //     contentPadding: EdgeInsets.zero,
              // //     leading: Image.asset(
              // //       'assets/images/moneyy.png',
              // //       width: 19,
              // //     ),
              // //     minLeadingWidth: 15,
              // //     title: const Text(
              // //       'Cash',
              // //       style: TextStyle(fontSize: 18),
              // //     ),
              // //     onTap: () {
              // //       Navigator.push(
              // //         context,
              // //         MaterialPageRoute(
              // //           builder: (context) => CashPayment(),
              // //         ),
              // //       );
              // //     },
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 20,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/credit.jpg"),
              // //     ),
              // //     title: Text('Card'),
              // //     onTap: () {},
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/mobile.png"),
              // //     ),
              // //     onTap: () {},
              // //     title: Text('Online'),
              // //   ),
              // //   Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // //   ListTile(
              // //     leading: CircleAvatar(
              // //       backgroundImage: AssetImage("assets/images/star.png"),
              // //     ),
              // //     onTap: () {},
              // //     title: Text('Credt'),
              // //   ),
              // //   const Divider(
              // //     thickness: 1,
              // //     indent: 60,
              // //     endIndent: 40,
              // //   ),
              // ],
              ),
        ],
      ),
    );
  }
}

class ListTilePayment extends StatelessWidget {
  const ListTilePayment(
      {Key? key, required this.image, this.onTap, required this.title})
      : super(key: key);
  final String title;
  final String image;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Image.asset(
          image,
          width: 19,
        ),
        minLeadingWidth: 15,
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        onTap: onTap);
  }
}
