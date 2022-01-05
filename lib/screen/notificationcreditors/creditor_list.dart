import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/creditor_controller.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class CreditorList extends StatelessWidget {
  const CreditorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _creditorcontroller = Provider.of<CreditorController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Add Clients',
          style: kAppBarText,
        ),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff30B700),
        child: Icon(Icons.add),
        onPressed: () {
          _creditorcontroller.nameController.clear();
          _creditorcontroller.phoneController.clear();
          _creditorcontroller.emailController.clear();

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70.0)),
                    width: 325.0,
                    height: 300.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                          child: _headText("Add new Creditor"),
                        ),
                        Divider(
                          thickness: 2.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Form(
                            key: _creditorcontroller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Enter name',
                                  ),
                                  controller:
                                      _creditorcontroller.nameController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Phone',
                                  ),
                                  controller:
                                      _creditorcontroller.phoneController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter phone number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'email',
                                  ),
                                  controller:
                                      _creditorcontroller.emailController,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SecondaryButton(
                            title: "Cancel",
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        SizedBox(
                          width: 10,
                        ),
                        PrimaryButton(
                          title: "Save",
                          onPressed: () {
                            if (_creditorcontroller.formKey.currentState!
                                .validate()) {
                              _creditorcontroller.addItemInTheList(
                                  _creditorcontroller.nameController.text,
                                  _creditorcontroller.phoneController.text,
                                  _creditorcontroller.emailController.text);
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Creditors added Sucessfully'),
                                  backgroundColor: kDefaultGreen,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )
                  ],
                );
              });
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          dataBody(_creditorcontroller, context),
          Container(
            width: 188,
            margin: EdgeInsets.only(bottom: 100),
            child: _creditorcontroller.selectedCreditor.isEmpty
                ? null
                : PrimaryButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    title: 'Send people',
                    onPressed: () {
                      _creditorcontroller.deleteSelected();
                      print(
                        'Send to ${_creditorcontroller.selectedCreditor.length} people',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  dataBody(CreditorController _clientcontroller, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            dividerThickness: 0.5,
            sortColumnIndex: 0,
            columnSpacing: 8,
            headingRowHeight: 50,
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Phone')),
              DataColumn(label: Text('Email')),
            ],
            rows: _clientcontroller.creditorList
                .map(
                  (creditor) => DataRow(
                    color: MaterialStateProperty.all(Colors.transparent),
                    selected:
                        _clientcontroller.selectedCreditor.contains(creditor),
                    onSelectChanged: (value) {
                      _clientcontroller.onSelectRow(value!, creditor);
                    },
                    cells: [
                      DataCell(
                        Text(creditor.name!),
                      ),
                      DataCell(
                        Text(creditor.phone!),
                      ),
                      DataCell(
                        Text(creditor.email!),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget textFormFieldWidget(TextEditingController controller, String hintText,
      TextInputType textInputType) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0, right: 16.0),
      child: TextFormField(
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class CreditorMenuItems extends StatelessWidget {
  const CreditorMenuItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: GestureDetector(
            child: Text('Import'),
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text('Export'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('FAQ'),
        ),
      ],
    );
  }

  onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        print('Import pressed');
        break;
      case 1:
        print('Export pressed');
        break;
      case 2:
        print('FAQ pressed');
        break;
    }
  }
}

Widget _headText(String head) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 12.0,
      bottom: 12.0,
    ),
    child: Text(
      head,
      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    ),
  );
}
