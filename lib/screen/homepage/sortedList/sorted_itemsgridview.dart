import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:pos/screen/homepage/localwidget/animate_itemgrid.dart';
import 'package:provider/provider.dart';

class SortedItemsGridView extends StatelessWidget {
  final Function(GlobalKey<State<StatefulWidget>>) onClick;
  final Future<List<Item>> futureItem;
  const SortedItemsGridView(
      {Key? key, required this.onClick, required this.futureItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _itemCon = Provider.of<ItemsController>(context);
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FutureBuilder(
          initialData: Provider.of<ItemsController>(context).items,
          future: futureItem,
          builder: (context, snapshot) {
            return GridView.builder(
              itemCount: _itemCon.sortedList.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = _itemCon.sortedList[index];
                return AnimateItemGrid(onClick: onClick, item: item);
              },
            );
          },
        ),
      ),
    );
  }
}
