import 'package:flutter/material.dart';
import 'package:pos/utils/constant.dart';

import 'addnewtaxdialog.dart';
import 'mobile_tax_list.dart';

class MobileTaxScreen extends StatefulWidget {
  const MobileTaxScreen({Key? key}) : super(key: key);

  @override
  _MobileTaxScreenState createState() => _MobileTaxScreenState();
}

class _MobileTaxScreenState extends State<MobileTaxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
        title: Text(
          'Tax',
          style: kAppBarText,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await addNewTaxDialog(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Charge",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MobileTaxList(),
            ],
          ),
        ),
      ),
    );
  }
}
