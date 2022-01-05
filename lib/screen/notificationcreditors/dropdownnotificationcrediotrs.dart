import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/ticket.dart';
import 'add_notification_creaditors.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';
import 'creditorsdropdownlist.dart';
import 'multi_checkbox_creditors.dart';

class DropdownNotificationCreditor extends StatelessWidget {
  const DropdownNotificationCreditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person),
                SizedBox(width: 20),
                Container(
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                '${_controller.notificationCreditorValue.value.name}'),
                          ),
                          IconButton(
                            onPressed: () {
                              showShipDialog(context, _controller);
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            splashRadius: 20,
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            boxHeight,
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                width: 80,
                height: 35,
                child: PrimaryButton(
                  title: 'Send',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddNotificationCreditors(),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showShipDialog(BuildContext context, TicketProvider _controller) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Container(
          margin: const EdgeInsets.only(right: 18.0, top: 90, bottom: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MultiCheckBoxCreditorsNotification(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            _controller.openTicketList.length,
                            (index) {
                              return AnimatedBuilder(
                                child: new Text(
                                    _controller.openTicketList.toString()),
                                animation:
                                    _controller.notificationCreditorValue,
                                builder: (context, child) {
                                  return CreditorsNotiDropDownList(
                                    index: index,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            child: Text(
                              'Clear',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Color(0xff30B700),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
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
