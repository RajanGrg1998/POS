import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos/utils/constant.dart';

class MenuItemText extends StatelessWidget {
  final String itemName;
  final dynamic itemQuantity;
  final dynamic itemRate;
  final Function()? onTap;
  final Function(BuildContext)? onEdit;
  final Function(BuildContext)? onDelete;
  const MenuItemText({
    Key? key,
    required this.itemName,
    required this.itemQuantity,
    required this.itemRate,
    this.onTap,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: DrawerMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            onPressed: onEdit,
            backgroundColor: Colors.transparent,
            foregroundColor: kDefaultGreen,
            icon: Icons.edit,
            spacing: 2,
          ),
          SlidableAction(
            backgroundColor: Colors.transparent,
            onPressed: onDelete,
            foregroundColor: Colors.red,
            icon: Icons.delete,
            spacing: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    itemName,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Text(
                    ' x $itemQuantity',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                'Rs. $itemRate',
                textAlign: TextAlign.left,
                textDirection: TextDirection.ltr,
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
