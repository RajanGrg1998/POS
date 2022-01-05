import 'package:flutter/material.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/screen/widgets/listbuilder/addson_builder.dart';
import 'package:pos/screen/widgets/listbuilder/discount_builder.dart';
import 'package:pos/screen/widgets/listbuilder/taxes_builder.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class EditItemScreen extends StatefulWidget {
  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Items',
          style: kAppBarText,
        ),
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Customer Edited Sucessfully'),
                  backgroundColor: kDefaultGreen,
                ),
              );
              // Provider.of<TicketProvider>(context, listen: false).toEditOrder =
              //     null;
              // int count = 0;
              // Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            style: TextButton.styleFrom(
              primary: Color(0xff30B700),
            ),
            child: Text('Save Changes'),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          boxHeight,
                          Text(
                            'Price',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          TextField(
                            controller: _price,
                            decoration: InputDecoration(
                              constraints: BoxConstraints(maxHeight: 32),
                              border: UnderlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text('Quantity'),
                          SizedBox(height: 16),
                          quantity(_controller),
                          boxHeight,
                        ],
                      ),
                    ),
                    boxHeight,
                    LabelText(labelName: 'AddsOn'),
                    boxHeight,
                    divider,
                    AddOnsListBuilder(controller: _controller),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(thickness: 1),
                    ),
                    boxHeight,
                    LabelText(labelName: 'Discounts'),
                    boxHeight,
                    divider,
                    DiscountListBuilder(controller: _controller),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: divider,
                    ),
                    boxHeight,
                    LabelText(labelName: 'Taxes'),
                    boxHeight,
                    divider,
                    TaxBuilder(controller: _controller),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Additional comments',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row quantity(TicketProvider _controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffB3B3B3),
              onSurface: Colors.white,
            ),
            onPressed: () {
              _controller.quanityDecrease();
            },
            child: Text('-'),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 7,
          child: TextField(
            textAlign: TextAlign.center,
            controller: _quantity,
            decoration: InputDecoration(),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffB3B3B3),
              onSurface: Colors.white,
            ),
            onPressed: () {
              _controller.quanityIncrease();
            },
            child: Text('+'),
          ),
        ),
      ],
    );
  }
}
