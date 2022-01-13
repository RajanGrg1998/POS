import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/item.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class AnimateItemGrid extends StatelessWidget {
  final GlobalKey imageGlobalKey = GlobalKey();

  final Item item;
  final void Function(GlobalKey) onClick;

  AnimateItemGrid({required this.onClick, required this.item});
  @override
  Widget build(BuildContext context) {
    // Improvement/Suggestion 3.1: Container is mandatory. It can hold images or whatever you want
    Container mandatoryContainer = Container(
      key: imageGlobalKey,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
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
    );

    return GestureDetector(
      onTap: () {
        onClick(imageGlobalKey);
        Provider.of<ItemsController>(context, listen: false)
            .addProductToCart(item);
        Provider.of<ItemsController>(context, listen: false).sum();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        height: 115,
        width: 102,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            mandatoryContainer,
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
      ),
    );
  }
}
