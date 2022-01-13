import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:provider/provider.dart';
import 'localwidget/animate_itemgrid.dart';

class ItemsGridView extends StatelessWidget {
  final Future<List<Item>> futureItem;
  final Function(GlobalKey<State<StatefulWidget>>) onClick;
  const ItemsGridView(
      {required this.futureItem, Key? key, required this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: FutureBuilder(
          initialData: Provider.of<ItemsController>(context).items,
          future: futureItem,
          builder: (context, AsyncSnapshot<List<Item>> snapshot) {
            return GridView.builder(
              itemCount: snapshot.data!.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 150,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return AnimateItemGrid(onClick: onClick, item: item);
              },
            );
          },
        ),
      ),
    );
  }
}
