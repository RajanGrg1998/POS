import 'package:flutter/material.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingController>(context);
    return Scaffold(
      body: ListView(
        children: [
          SettingList(
            title: "System Settings",
            displayList: _controller.systemSettingList,
          ),
          SettingList(
            title: "POS Settings",
            displayList: _controller.posSettingList,
          )
        ],
      ),
    );
  }
}

class SettingList extends StatelessWidget {
  final String? title;
  final List? displayList;
  SettingList({@required this.title, @required this.displayList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title!,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 1,
          color: Color(0XFFE0E0E0),
        ),
        Column(
          children: displayList!
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(item['title']),
                        contentPadding: EdgeInsets.zero,
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 16,
                        ),
                        onTap: () {
                          print(item['title']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => item['route'],
                              ));
                        },
                      ),
                      Divider(
                        height: 0,
                        thickness: 1,
                        color: Color(0XFFE0E0E0),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
