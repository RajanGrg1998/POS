import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class AnimateItemList extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();

  final Item item;
  final void Function(GlobalKey) onClick;

  AnimateItemList({required this.onClick, required this.item});
  @override
  Widget build(BuildContext context) {
    // Improvement/Suggestion 3.1: Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: imageGlobalKey,
      width: 60,
      height: 60,
      color: Colors.transparent,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          imageUrl: item.image!,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              color: kDefaultGreen,
              value: downloadProgress.progress,
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        onClick(imageGlobalKey);
        Provider.of<ItemsController>(context, listen: false)
            .addProductToCart(item);
        Provider.of<ItemsController>(context, listen: false).sum();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            mandatoryContainer,
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: kBorderColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(item.name),
                    ),
                    Text('Rs.${item.price}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
