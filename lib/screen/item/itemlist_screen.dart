import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/api_response.dart';
import 'package:pos/model/item.dart';
import '../add_item.dart';
import 'editItem_screen.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

enum FoodCategory {
  drinks,
  alcohol,
  snacks,
}

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  TextEditingController controller = new TextEditingController();
  FoodCategory _groupValue = FoodCategory.snacks;
  late Future<APIResponse<List<Item>>> futureItem;
  void initState() {
    super.initState();
    futureItem = Future.delayed(const Duration(milliseconds: 200),
        () => Provider.of<ItemsController>(context, listen: false).getItems());

    // sortByCategory();
  }

  @override
  Widget build(BuildContext context) {
    var _apiCon = Provider.of<ItemsController>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => AddItem(),
              ))
              .then(
                (context) => _apiCon.getItems(),
              );
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: _apiCon.onSearchTextChanged,
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
                child: FutureBuilder(
                  future: futureItem,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _apiCon.searchItems.length != 0 ||
                              controller.text.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) => divider,
                              itemCount: _apiCon.searchItems.length,
                              itemBuilder: (context, index) {
                                final jsonData = _apiCon.searchItems[index];
                                return Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  key: ValueKey(jsonData),
                                  background: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.only(left: 16),
                                    child: Align(
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    _apiCon.deleteNote(jsonData.id);
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateItemScreen(
                                                    item: jsonData),
                                          ))
                                          .then(
                                            (context) => _apiCon.getItems(),
                                          );
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        imageUrl: jsonData.image!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    title: Text(jsonData.name),
                                    trailing: Text('Rs.${jsonData.price}'),
                                  ),
                                );
                              },
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) => divider,
                              itemCount: _apiCon.items.length,
                              itemBuilder: (context, index) {
                                final jsonData = _apiCon.items[index];
                                return Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  key: ValueKey(jsonData),
                                  background: Container(
                                    color: Colors.red,
                                    padding: EdgeInsets.only(left: 16),
                                    child: Align(
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  onDismissed: (direction) {
                                    _apiCon.deleteNote(jsonData.id);
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateItemScreen(
                                                    item: jsonData),
                                          ))
                                          .then(
                                            (context) => _apiCon.getItems(),
                                          );
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: CachedNetworkImage(
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        imageUrl: jsonData.image!,
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    title: Text(jsonData.name),
                                    trailing: Text('Rs.${jsonData.price}'),
                                  ),
                                );
                              },
                            );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return ShimmerItemList();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerItemList extends StatelessWidget {
  const ShimmerItemList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 18,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CircleAvatar(backgroundColor: Colors.grey[100])),
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(height: 20.0, color: Colors.grey[300]),
          ),
        );
      },
    );
  }
}
