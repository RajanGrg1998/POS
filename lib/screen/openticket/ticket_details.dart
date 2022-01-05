import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/screen/split/paymentmethod.dart';
import 'package:pos/screen/widgets/menu_items.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'edit_Items_screen.dart';

class TicketDetail extends StatelessWidget {
  final int index;
  TicketDetail(this.index);

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          '${_controller.openTicketList[index].name}',
          style: kAppBarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.2),
                  ),
                ),
                child: GestureDetector(
                  onTap: () {
                    showShipDialog(context, _controller);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                            '${_controller.shippingItem.value.shippingName}'),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Items Ordered',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      itemCount: _controller.itemsOrdered.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final itemsOrdered = _controller.itemsOrdered[index];
                        return MenuItemText(
                          onDelete: (context) {
                            _controller.dismisItemOrdered(itemsOrdered);
                          },
                          itemName: itemsOrdered.itemName ?? '',
                          itemQuantity: itemsOrdered.itemQuantity,
                          itemRate: itemsOrdered.itemRate,
                          onTap: () {
                            Provider.of<TicketProvider>(context, listen: false)
                                .toEditOrder = _controller.itemsOrdered[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditItemScreen(),
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         EditItemScreen(itemsOrdered),
                            //   ),
                            // );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => sizeHeight(),
                    ),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Rs. 3000',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
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
      ),
    );
  }

  SizedBox sizeHeight() {
    return SizedBox(
      height: 10,
    );
  }

  void showShipDialog(BuildContext context, TicketProvider _controller) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Container(
          margin: const EdgeInsets.only(right: 15.0, top: 110),
          child: Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 154,
                height: 150,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    _controller.shipping.length,
                    (index) {
                      return AnimatedBuilder(
                        child: new Text(_controller.shipping.toString()),
                        animation: _controller.shippingItem,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 0.9,
                            child: RadioListTile<Shipping>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              title: Text(
                                '${_controller.shipping[index].shippingName}',
                                style: TextStyle(fontSize: 14),
                              ),
                              value: _controller.shipping[index],
                              groupValue: _controller.shippingItem.value,
                              onChanged: (value) {
                                _controller.selectedShippingRadio(value!);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
