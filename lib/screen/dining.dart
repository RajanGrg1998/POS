import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/model/diningModel.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class DiningScreen extends StatelessWidget {
  const DiningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Dining',
          style: kAppBarText,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _diningContent(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 30.0,
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xff30B700),
          onPressed: () {
            addDining(context);
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _diningContent(BuildContext context) {
    DiningNotifier diningNotifier =
        Provider.of<DiningNotifier>(context, listen: true);
    return ListView.builder(
        itemCount: diningNotifier.diningDetail.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
                left: 16.0, right: 16.0, bottom: 16.0, top: 8.0),
            child: Consumer<DiningNotifier>(
              builder: (context, notifier, child) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(notifier.diningDetail[index].diningName),
                      onTap: () =>
                          print(notifier.diningDetail[index].diningName),
                    ),
                    Divider(
                      thickness: 1.0,
                    )
                  ],
                );
              },
            ),
          );
        });
  }

  void addDining(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return DiningAlertDialogeComponent();
        });
  }
}

class DiningAlertDialogeComponent extends StatefulWidget {
  const DiningAlertDialogeComponent({Key? key}) : super(key: key);

  @override
  _DiningAlertDialogeComponentState createState() =>
      _DiningAlertDialogeComponentState();
}

class _DiningAlertDialogeComponentState
    extends State<DiningAlertDialogeComponent> {
  final TextEditingController _diningName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DiningNotifier diningNotifier =
        Provider.of<DiningNotifier>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Text(
          'Add New Dining',
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.8, color: Color(0xffE0E0E0)),
          ),
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter name eg. delivery',
            ),
            controller: _diningName,
            validator: (String? value) {
              if (value == null) return ('Please add payment type');
            },
          ),
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SecondaryButton(
                title: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 20.0,
              ),
              PrimaryButton(
                title: 'Save',
                onPressed: () {
                  diningNotifier.addDining(
                    DiningModel(_diningName.text, false),
                  );
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
