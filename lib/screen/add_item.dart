import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/create_item.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

enum itemUnit {
  each,
  volume,
}

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  itemUnit soldByGroupValue = itemUnit.each;

  TextEditingController _itemName = TextEditingController();
  TextEditingController _itemPrice = TextEditingController();
  TextEditingController _itemDes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Item Details',
          style: kAppBarText,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final name = _itemName.text;
              final price = _itemPrice.text;
              final dec = _itemDes.text;

              final createItem =
                  CreateItem(name: name, price: price, description: dec);
              final result =
                  await Provider.of<ItemsController>(context, listen: false)
                      .creareUser(createItem);
              final title = 'Done';
              final text = result.error == true
                  ? (result.errorMessage ?? 'No Internet Connection')
                  : 'Created';

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(title),
                  content: Text(text),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Ok'))
                  ],
                ),
              ).then((data) {
                if (result.data != null) {
                  Navigator.of(context).pop();
                }
              });
              // final addItem = Item(
              //   name: _itemName.text,
              //   price: _itemPrice.text,
              //   description: _itemDes.text,
              //   id: '',
              // );
              // Provider.of<ItemsController>(context, listen: false)
              //     .createItem(addItem);
              // Navigator.of(context).pop();
            },
            child: Text("Save"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddTextField(
                hintText: 'Item Name',
                textEditingController: _itemName,
              ),
              AddTextField(
                hintText: 'Price',
                textEditingController: _itemPrice,
              ),
              AddTextField(
                hintText: 'Description',
                textEditingController: _itemDes,
              ),
              AddTextField(
                hintText: 'BarCode',
              ),
              Row(
                children: [
                  Text(
                    'Sold by',
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.green),
                        value: itemUnit.each,
                        groupValue: soldByGroupValue,
                        onChanged: (itemUnit? val) {
                          setState(() {
                            soldByGroupValue = val!;
                          });
                        },
                      ),
                      Text('Each'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        fillColor: MaterialStateProperty.all(Colors.green),
                        value: itemUnit.volume,
                        groupValue: soldByGroupValue,
                        onChanged: (itemUnit? val) {
                          setState(() {
                            soldByGroupValue = val!;
                          });
                        },
                      ),
                      Text('Weight/Volume'),
                    ],
                  ),
                ],
              ),
              NewSection(
                title: 'Inventory',
              ),
              ListTileWithCupertinoSwitch(
                title: 'Track Stock',
                value: false,
              ),
              AddTextField(
                hintText: 'In Stock',
              ),
              AddTextField(
                hintText: 'Low Stock',
              ),
              NewSection(
                title: 'Addons',
              ),
              ListTileWithCupertinoSwitch(
                title: 'Extra Cheese',
                value: false,
              ),
              ListTileWithCupertinoSwitch(
                title: 'Toppings',
                value: false,
              ),
              ListTileWithCupertinoSwitch(
                title: 'Extra Sausage',
                value: false,
              ),
              ListTileWithCupertinoSwitch(
                title: 'Low Stock',
                value: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewSection extends StatelessWidget {
  final String title;

  const NewSection({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Divider()
        ],
      ),
    );
  }
}

class ListTileWithCupertinoSwitch extends StatelessWidget {
  final String title;
  final bool value;

  const ListTileWithCupertinoSwitch(
      {Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      trailing: Transform.scale(
        scale: 0.6,
        child: CupertinoSwitch(
          trackColor: Colors.black,
          value: value,
          onChanged: (val) {},
        ),
      ),
    );
  }
}
