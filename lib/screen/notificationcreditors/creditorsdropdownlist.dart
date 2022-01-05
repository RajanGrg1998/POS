import 'package:flutter/material.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class CreditorsNotiDropDownList extends StatelessWidget {
  const CreditorsNotiDropDownList({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Column(
      children: [
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: _controller.openTicketList[index].isChecked,
          onChanged: (value) {
            _controller.isSingleCheck(index, value);
          },
          title: Text(
            '${_controller.openTicketList[index].name}',
          ),
          subtitle: Text(
            '${_controller.openTicketList[index].amount}',
          ),
        ),
        divider,
      ],
    );
  }
}
