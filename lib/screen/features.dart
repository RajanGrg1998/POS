import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class FeaturesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Text(
          "Features",
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
      body: FeaturesBody(),
    );
  }
}

class FeaturesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controller.featureOptionList.length,
              itemBuilder: (context, int index) {
                return ListTile(
                  title: Text(
                    _controller.featureOptionList[index].title!,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  subtitle: Text(
                    _controller.featureOptionList[index].subtitle!,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                      trackColor: Colors.black,
                      value: _controller.featureOptionList[index].isOn!,
                      onChanged: (val) {
                        _controller.changeSwitchValue(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SecondaryButton(
                  title: 'Cancel',
                  onPressed: () {},
                ),
                SizedBox(
                  width: 16,
                ),
                PrimaryButton(
                  title: 'Save',
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
