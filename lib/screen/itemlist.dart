import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';

import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

import 'add_item.dart';

enum FoodCategory {
  drinks,
  alcohol,
  snacks,
}

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  FoodCategory _groupValue = FoodCategory.snacks;
  late Future<List<Item>> futureItem;
  void initState() {
    super.initState();
    futureItem =
        Provider.of<ItemsController>(context, listen: false).fetchItems();
    // sortByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  icon: Icon(Icons.sort),
                  onSelected: (FoodCategory val) {
                    setState(() {
                      _groupValue = val;
                    });
                    // sortByCategory();
                  },
                  itemBuilder: (context) => <PopupMenuItem<FoodCategory>>[
                    PopupMenuItem(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sort by'),
                          Transform.scale(
                            scale: 1.2,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      padding: EdgeInsets.zero,
                      child: ListTile(
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.only(left: 0, right: 8),
                        horizontalTitleGap: 4,
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.snacks,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: Text('Snacks'),
                      ),
                      value: FoodCategory.snacks,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 0, right: 8),
                        visualDensity: VisualDensity.compact,
                        horizontalTitleGap: 4,
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.drinks,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: Text('Drinks'),
                      ),
                      value: FoodCategory.drinks,
                    ),
                    PopupMenuItem(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ListTile(
                        horizontalTitleGap: 4,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.only(left: 0, right: 8),
                        leading: Radio<FoodCategory>(
                          value: FoodCategory.alcohol,
                          groupValue: _groupValue,
                          onChanged: (FoodCategory? val) {
                            setState(() {
                              _groupValue = val!;
                            });
                          },
                        ),
                        title: Text('Alcohol'),
                      ),
                      value: FoodCategory.alcohol,
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: FutureBuilder<List<Item>>(
                        initialData:
                            Provider.of<ItemsController>(context).items,
                        future: futureItem,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Item>> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: snapshot.data!
                                  .asMap()
                                  .entries
                                  .map(
                                    (item) => GestureDetector(
                                      child: Column(
                                        children: [
                                          item.key != 0
                                              ? Divider()
                                              : SizedBox.shrink(),
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: CachedNetworkImage(
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            24),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                imageUrl: item.value.image!,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            title: Text(item.value.name),
                                            trailing:
                                                Text('Rs.${item.value.price}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDefaultGreen,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => AddItem(),
              ))
              .then(
                (context) =>
                    Provider.of<ItemsController>(context, listen: false)
                        .fetchItems(),
              );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
