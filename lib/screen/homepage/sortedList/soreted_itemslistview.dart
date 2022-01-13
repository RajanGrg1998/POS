import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:provider/provider.dart';

import '../localwidget/animate_itemlist.dart';

class ItemsSoretedListView extends StatelessWidget {
  const ItemsSoretedListView(
      {Key? key, required this.onClick, required this.futureItem})
      : super(key: key);
  final void Function(GlobalKey<State<StatefulWidget>>) onClick;
  final Future<List<Item>> futureItem;

  @override
  Widget build(BuildContext context) {
    var _itemCon = Provider.of<ItemsController>(context);
    return Expanded(
        child: FutureBuilder(
      future: futureItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: _itemCon.sortedList.length,
            itemBuilder: (context, index) {
              final item = _itemCon.sortedList[index];
              return AnimateItemList(onClick: onClick, item: item);
            },
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
