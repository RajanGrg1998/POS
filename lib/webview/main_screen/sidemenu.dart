import 'package:flutter/material.dart';
import 'package:pos/screen/homepage/homepage.dart';
import 'package:pos/webview/components/drawerheader.dart';
import 'package:pos/webview/components/side_navbar_tile.dart';

class SideMenu extends StatelessWidget {
  final Function onNavIndexChanged;
  final int selectedIndex;
  final List<MenuOptions> menuOptions;
  SideMenu(
      {required this.onNavIndexChanged,
      required this.selectedIndex,
      required this.menuOptions});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          NavDrawerHeaderText(
            title: 'Owner',
            personName: 'Amit Shrestha',
            userName: 'sthaa001',
          ),
          Column(
            children: menuOptions
                .map((menuOption) => SideNavBarTile(
                      sideBarIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? Color(0xff30B700)
                              : Colors.transparent,
                      textIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? Color(0xff30B700)
                              : Colors.black,
                      iconIndicatorColor:
                          selectedIndex == menuOptions.indexOf(menuOption)
                              ? Color(0xff30B700)
                              : Colors.black,
                      title: menuOption.title,
                      icon: menuOption.icon,
                      press: () {
                        onNavIndexChanged(menuOptions.indexOf(menuOption));
                        Navigator.pop(context);
                      },
                      selected:
                          selectedIndex == menuOptions.indexOf(menuOption),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
