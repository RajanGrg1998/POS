import 'package:flutter/material.dart';
import 'package:pos/components/adds_on_tilte.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/utils/constant.dart';

class TaxBuilder extends StatelessWidget {
  const TaxBuilder({
    Key? key,
    required TicketProvider controller,
  })  : _controller = controller,
        super(key: key);

  final TicketProvider _controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tax = _controller.taxes[index];
          return AddsOnTile(
            name: '${tax.taxName}',
            isChecked: tax.isTaxChecked,
            chechBoxCallback: (value) {
              _controller.changeTaxeSwitchValue(index);
            },
            onTap: () {
              _controller.changeTaxeSwitchValue(index);
            },
          );
        },
        separatorBuilder: (context, index) => divider,
        itemCount: _controller.discounts.length);
  }
}
