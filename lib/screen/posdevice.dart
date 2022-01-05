import 'package:flutter/material.dart';
import 'package:pos/utils/constant.dart';

class PosDeviceScreen extends StatelessWidget {
  const PosDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Text(
          "Devices",
          style: kAppBarText,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff30B700),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 24),
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('POS ${index + 1}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                index.isEven
                    ? Icon(
                        Icons.circle,
                        size: 8,
                        color: Color(0xff30B700),
                      )
                    : Icon(
                        Icons.circle_outlined,
                        size: 8,
                        color: Color(0xff707070),
                      ),
                SizedBox(width: 8),
                index.isEven ? Text('Active ') : Text('InActive'),
              ],
            ),
          );
        },
        itemCount: 3,
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Color(0xffE0E0E0),
          thickness: 1,
        ),
      ),
    );
  }
}
