import 'package:flutter/material.dart';
import 'package:pos/screens/create_customer.dart';
import 'package:pos/screens/profile.dart';
import 'package:pos/utilities/constant.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  List<String> customers = [
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (MediaQuery.of(context).size.width < 600)
          ? AppBar(
              elevation: 0,
              titleSpacing: 10,
              title: Text(
                'Add Customer to Ticket',
                style: kAppBarText,
              ),
            )
          : PreferredSize(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Customer to Ticket',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close))
                  ],
                ),
              ),
              preferredSize: Size.fromHeight(60)),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: kBorderColor),
                  bottom: BorderSide(color: kBorderColor),
                ),
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    icon: Icon(
                      Icons.search,
                      color: kIconColor,
                    ),
                    hintText: 'Search Customer',
                    hintStyle: TextStyle(color: kAccentColor, fontSize: 14),
                    border: InputBorder.none
                    // labelText: labelText,
                    // focusedBorder: UnderlineInputBorder(
                    //   borderSide: BorderSide(color: kAccentColor, width: 1),
                    // ),
                    ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (value) {},
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Recent Customers',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      (MediaQuery.of(context).size.width > 600)
                          ? showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: [
                                    Container(
                                      width: 700,
                                      height: 800,
                                      color: Colors.red,
                                      child: Profile(),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(width: 1, color: kBorderColor),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(customers[index]),
                                  Text(
                                    '98324234234',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDefaultGreen,
        child: Icon(Icons.add),
        onPressed: () {
          (MediaQuery.of(context).size.width < 600)
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateCustomer(),
                  ),
                )
              : showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        Container(
                          width: 600,
                          height: 800,
                          color: Colors.red,
                          child: CreateCustomer(),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}

class AddCustomerTablet extends StatelessWidget {
  final List<String> customers = [
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
    'Shak Ruk Khan',
    'Chelsi Ketan',
    'Kriti Gurung',
    'Amit Shrestha',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              // Icon(Icons.ac_unit),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: kBorderColor),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customers[index]),
                      Text(
                        '98324234234',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
