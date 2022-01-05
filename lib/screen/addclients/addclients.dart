import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/client_controller.dart';
import 'package:pos/screen/notificationcreditors/creditor_list.dart';
import 'package:pos/utils/constant.dart';

import 'package:provider/provider.dart';

class AddClient extends StatelessWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _clientcontroller = Provider.of<ClientController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Clients',
          style: kAppBarText,
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
          CreditorMenuItems(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: dataBody(_clientcontroller, context),
            ),
          ),
          Container(
            width: 188,
            margin: EdgeInsets.only(bottom: 100),
            child: _clientcontroller.selectedUser.isEmpty
                ? null
                : PrimaryButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    title:
                        'Send To- ${_clientcontroller.selectedUser.length} people',
                    onPressed: () {
                      print(
                          'Send to ${_clientcontroller.selectedUser.length} people');
                    },
                  ),
          )
        ],
      ),
    );
  }

  dataBody(ClientController _clientcontroller, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dividerThickness: 0.5,
            sortAscending: _clientcontroller.sort,
            sortColumnIndex: 0,
            columnSpacing: 8,
            headingRowHeight: 50,
            columns: [
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
              DataColumn(label: Text('')),
            ],
            rows: _clientcontroller.creditorList
                .map(
                  (client) => DataRow(
                    color: MaterialStateProperty.all(Colors.transparent),
                    selected: _clientcontroller.selectedUser.contains(client),
                    onSelectChanged: (value) {
                      _clientcontroller.onSelectRow(value!, client);
                    },
                    cells: [
                      DataCell(
                        Text(client.name!),
                      ),
                      DataCell(
                        Text(client.phone!),
                      ),
                      DataCell(
                        Text(client.email!),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        Positioned(
          right: 5,
          top: 2,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              cursorColor: kDefaultGreen,
              autofocus: false,
              onEditingComplete: () {},
              decoration: InputDecoration(
                hintText: 'Serach',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
