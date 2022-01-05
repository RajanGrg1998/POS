import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/storesController.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class StoresScreen extends StatefulWidget {
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  final _nameController = TextEditingController();

  final _locationController = TextEditingController();

  final _contactController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var _storeController = Provider.of<StoreController>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Stores",
          style: kAppBarText,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _nameController.clear();
          _contactController.clear();
          _descriptionController.clear();
          _locationController.clear();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  content: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70.0)),
                    width: 325.0,
                    height: 404.0,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          _headText("Add new store"),
                          Divider(
                            thickness: 2.0,
                          ),
                          TextFormFieldWidget(
                            controller: _nameController,
                            hintText: "Enter name eg:Star Lounge",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            controller: _locationController,
                            hintText: "Location",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Location';
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            controller: _contactController,
                            hintText: "Contact No",
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 10) {
                                return 'Please enter Contact No';
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            controller: _descriptionController,
                            hintText: "Description",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Description';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SecondaryButton(
                              title: "Cancel",
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          SizedBox(width: 10),
                          PrimaryButton(
                            title: "Save",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _storeController.addItemInTheList(
                                    _nameController.text,
                                    _locationController.text,
                                    _contactController.text);
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      body: StoreBody(),
    );
  }

  Widget textFormFieldWidget(
      TextEditingController controller, String hintText) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget(
      {Key? key, this.validator, this.controller, this.hintText})
      : super(key: key);
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class StoreBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _storeController = Provider.of<StoreController>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.0, left: 20.0),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(0.7),
          1: FlexColumnWidth(0.8),
          2: FlexColumnWidth(0.5)
        },
        border: TableBorder(
            bottom: BorderSide(
              color: Colors.grey.shade200,
            ),
            horizontalInside: BorderSide(color: Colors.grey.shade200)),
        children: [
          TableRow(
            children: [
              TableCell(
                child: _headText("Name"),
              ),
              TableCell(
                child: _headText("Location"),
              ),
              TableCell(
                child: _headText("Contact"),
              ),
            ],
          ),
          for (var item in _storeController.storeOption)
            TableRow(children: [
              TableCell(child: _listText(item.name.toString())),
              TableCell(child: _listText(item.location.toString())),
              TableCell(child: _listText(item.contact.toString()))
            ])
        ],
      ),
    );
  }

  Widget _listText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    );
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
      maxLines: 1,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );
}
