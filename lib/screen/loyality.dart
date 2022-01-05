import 'package:flutter/material.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/components/header_container.dart';

class LoyalityScreen extends StatefulWidget {
  const LoyalityScreen({Key? key}) : super(key: key);

  @override
  _LoyalityScreenState createState() => _LoyalityScreenState();
}

class _LoyalityScreenState extends State<LoyalityScreen> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 265,
      child: Column(
        children: [
          HeaderContainer(
            title: 'Add new loyality',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                AddTextField(
                  hintText: 'Enter bonus eg. loyalty points',
                  textEditingController: _text,
                  validateText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                boxHeight,
                AddTextField(
                  hintText: 'Bonus in %',
                ),
              ],
            ),
          ),
          boxHeight,
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PrimaryButton(title: 'Cancel', onPressed: () {}),
                boxWidth,
                SecondaryButton(
                    title: 'Save',
                    onPressed: () {
                      setState(() {
                        _text.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
