import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:provider/provider.dart';

import 'localwidget/animate_itemlist.dart';

class ItemsListView extends StatelessWidget {
  const ItemsListView({
    required this.futureItem,
    Key? key,
    required this.onClick,
  }) : super(key: key);
  final Future<List<Item>> futureItem;
  final void Function(GlobalKey<State<StatefulWidget>>) onClick;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          initialData: Provider.of<ItemsController>(context).items,
          future: futureItem,
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return AnimateItemList(onClick: onClick, item: item);
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
