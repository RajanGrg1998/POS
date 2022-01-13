import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class EditQuantityScreen extends StatefulWidget {
  const EditQuantityScreen({
    Key? key,
    required this.ticektItem,
  }) : super(key: key);
  final TicektItem ticektItem;

  @override
  State<EditQuantityScreen> createState() => _EditQuantityScreenState();
}

class _EditQuantityScreenState extends State<EditQuantityScreen> {
  // TextEditingController _itemQty = TextEditingController();
  @override
  void initState() {
    super.initState();

    Provider.of<ItemsController>(context, listen: false).itemQty.text =
        widget.ticektItem.quantity.toString();
  }

  // final int index;
  @override
  Widget build(BuildContext context) {
    var _itemCon = Provider.of<ItemsController>(context);

    // _itemCon.itemQuantity.text = ticektItem.quantity.toString();

    return Scaffold(
      backgroundColor: kDefaultBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _itemCon.onSave(widget.ticektItem, context);
            },
            style: TextButton.styleFrom(
              primary: Color(0xff30B700),
            ),
            child: Text('Save'),
          )
        ],
        title: Text(
          '${widget.ticektItem.item!.name}',
          style: kAppBarText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffB3B3B3),
                      onSurface: Colors.white,
                    ),
                    onPressed: () {
                      _itemCon.decrease();
                    },
                    child: Text('-'),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    controller: _itemCon.itemQty,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                      signed: true,
                    ),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
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
                      _itemCon.increase();
                    },
                    child: Text('+'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
