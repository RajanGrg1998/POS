import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos/components/listile.dart';
import 'package:pos/controller/ticket.dart';
import 'package:pos/screen/widgets/timeago.dart';
import 'ticket_details.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class TicketsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<TicketProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Open Ticket (${_controller.openTicketList.length})',
          style: kAppBarText,
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          // TextButton(
          //   style: TextButton.styleFrom(
          //     primary: Color(0xff30B700),
          //   ),
          //   onPressed: () {},
          //   child: Text(
          //     'merge',
          //     style: TextStyle(fontSize: 16),
          //   ),
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 18),
                child: Transform.scale(
                  scale: 0.7,
                  child: Transform.translate(
                    offset: Offset(0, 4),
                    child: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.name,
                  decoration: new InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, top: 15, right: 15),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(context, _controller);
                },
                icon: Icon(Icons.sort),
                splashRadius: 20,
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: AnimatedList(
              key: _controller.openTicketKey,
              initialItemCount: _controller.openTicketList.length,
              itemBuilder: (context, index, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: _builtOpenTicket(_controller, index, context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Slidable _builtOpenTicket(
      TicketProvider _controller, int index, BuildContext context) {
    final openTicket = _controller.openTicketList[index];
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            icon: Icons.delete,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Delete',
            onPressed: (context) {
              _controller.dismisDelete(openTicket, index,
                  _builtOpenTicket(_controller, index, context));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: const Duration(milliseconds: 600),
                  content: Text('Ticket deleted Sucessfully'),
                  backgroundColor: kDefaultGreen,
                ),
              );
            },
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(color: kBorderColor, width: 1),
        )),
        child: TileListBox(
          merge: _controller.openTicketList[index].ismerged == true
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('Merge'),
                )
              : null,
          isChecked: openTicket.isChecked!,
          chechBoxCallback: (val) {
            _controller.changeSwitchValue(index);
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TicketDetail(index)),
            );
          },
          created: '${TimeAgo.timeAgoSinceDate(openTicket.created!)}',
          taxTitle: '${openTicket.name}',
          amount: '${openTicket.amount}',
          iconData: Icons.person,
        ),
      ),
    );
  }

  void showDialog(BuildContext context, TicketProvider _controller) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Container(
          margin: const EdgeInsets.only(right: 15.0, top: 90),
          child: Align(
            alignment: Alignment.topRight,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 162,
                height: 220,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                        child: Text(
                          "Sort By",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Column(
                        children: List.generate(
                          _controller.sortby.length,
                          (index) {
                            return AnimatedBuilder(
                              child: new Text(_controller.sortby.toString()),
                              animation: _controller.selectedItem,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: 0.9,
                                  child: RadioListTile<SortBy>(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      '${_controller.sortby[index].name}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    value: _controller.sortby[index],
                                    groupValue: _controller.selectedItem.value,
                                    onChanged: (value) {
                                      _controller.selectedRadio(value!);
                                      Navigator.pop(context);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ]),
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

  // _buildItem(BuildContext context, TicketProvider _controller, index) {
  //   final openTicket = _controller.openTicketList[index];
  //   return TileListBox(
  //     merge: _controller.openTicketList[index].ismerged == true
  //         ? Padding(
  //             padding: const EdgeInsets.all(4.0),
  //             child: Text('Merge'),
  //           )
  //         : null,
  //     isChecked: openTicket.isChecked!,
  //     chechBoxCallback: (val) {
  //       _controller.changeSwitchValue(index);
  //     },
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => TicketDetail(index)),
  //       );
  //     },
  //     created: '${TimeAgo.timeAgoSinceDate(openTicket.created!)}',
  //     taxTitle: '${openTicket.name}',
  //     amount: '${openTicket.amount}',
  //     iconData: Icons.person,
  //   );
  // }
}
