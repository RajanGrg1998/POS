import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/screen/item/editqtyscreen.dart';
import 'package:pos/screen/split/paymentmethod.dart';
import 'package:pos/screen/widgets/menu_items.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class TicketEditScreen extends StatelessWidget {
  const TicketEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var itemsCon = Provider.of<ItemsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Ticket',
              style: kAppBarText,
            ),
            SizedBox(
              width: 5,
            ),
            Stack(
              children: [
                SvgPicture.asset(
                  'assets/images/Ticket White.svg',
                  color: Colors.black,
                  height: 36,
                  width: 27,
                ),
                Positioned(
                  child: Text(
                    '${Provider.of<ItemsController>(context).ticketList.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                  top: 8,
                  left: 8,
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              itemsCon.clearAllItems();
              itemsCon.total = 0;
            },
            style: TextButton.styleFrom(
              primary: Color(0xff30B700),
            ),
            child: Text('Clear Ticket'),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items Ordered',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16),
            AnimatedList(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              key: itemsCon.itemKey,
              initialItemCount: itemsCon.ticketList.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: _builtAddItemList(itemsCon, index, context),
                );
              },
            ),
            // ...List.generate(items.ticketList.length, (index) {
            //   final ticket = items.ticketList[index];
            //   return MenuItemText(
            //       onEdit: (context) {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //               builder: (context) => EditQuantityScreen(
            //                 ticektItem: ticket,
            //                 index: index,
            //               ),
            //             ));
            //       },
            //       onDelete: (context) {
            //         items.removeAtIndex(ticket);
            //       },
            //       itemName: '${ticket.item!.name}',
            //       itemQuantity: '${ticket.quantity}',
            //       itemRate: '${ticket.item!.price}');
            // }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(
                thickness: 1,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  itemsCon.ticketList.isEmpty
                      ? 'Rs. 0.0'
                      : 'Rs. ${itemsCon.total}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 16.5),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    title: 'Save Order',
                    padding: EdgeInsets.symmetric(vertical: 20),
                    onPressed: () {},
                  ),
                ),
                VerticalDivider(
                  width: 1,
                ),
                Expanded(
                  child: PrimaryButton(
                    title: 'Procced to Pay',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentMethod(),
                      ));
                    },
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
                // PrimaryButton(
                //   title: 'Save Order',
                //   onPressed: () {},
                //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                // ),

                // PrimaryButton(
                //   title: 'Procced to Pay',
                //   onPressed: () {},
                //   padding: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _builtAddItemList(ItemsController itemsCon, int index, BuildContext context) {
    final ticket = itemsCon.ticketList[index];
    return MenuItemText(
      onEdit: (context) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditQuantityScreen(
                ticektItem: ticket,
              ),
            ));
      },
      onDelete: (context) {
        itemsCon.removeAtIndex(
            ticket, index, _builtAddItemList(itemsCon, index, context));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: const Duration(milliseconds: 600),
            content: Text('Ticket deleted Sucessfully'),
            backgroundColor: kDefaultGreen,
          ),
        );
      },
      itemName: '${ticket.item!.name}',
      itemQuantity: '${ticket.quantity}',
      itemRate: '${ticket.item!.price}',
    );
  }
}
