import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:pos/utilities/constant.dart';
import 'package:provider/provider.dart';

class ItemsGridView extends StatelessWidget {
  final Future<List<Item>> futureItem;
  const ItemsGridView({required this.futureItem, Key? key}) : super(key: key);
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
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 115,
                  width: 102,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        imageUrl: item.image!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            color: kDefaultGreen,
                            value: downloadProgress.progress,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.46),
                        ),
                        child: Center(
                          child: Text(
                            item.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
