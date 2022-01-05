import 'package:flutter/material.dart';
import 'package:pos/controller/ticket.dart';
import 'package:provider/provider.dart';

class MultiCheckBoxCreditorsNotification extends StatelessWidget {
  const MultiCheckBoxCreditorsNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffE0E0E0)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Checkbox(
            value: _controller.allNotification[0].isChecked,
            onChanged: (value) {
              _controller.isCheckAll(value);
            },
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
