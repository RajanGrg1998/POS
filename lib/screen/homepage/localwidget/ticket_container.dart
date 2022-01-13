import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/screen/openticket/tickets_screen.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class TicketContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    var _itemCon = Provider.of<ItemsController>(context);
    return Container(
      // height: 78,
      decoration: BoxDecoration(
        color: kDefaultGreen,
        borderRadius: BorderRadius.circular(5),
      ),
      // padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketsScreen(),
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    'Open Tickets',
                    style: kSemiLargeText,
                  ),
                  Text(
                    '${_controller.openTicketList.length}',
                    style: kSemiLargeText,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(13),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: kDefaultBackgroundColor),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Amount',
                    style: kSemiLargeText,
                  ),
                  Text(
                    _itemCon.ticketList.isNotEmpty
                        ? '${_itemCon.total}'
                        : '0.0',
                    style: kSemiLargeText,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
