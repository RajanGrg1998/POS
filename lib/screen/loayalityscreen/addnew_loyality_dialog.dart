import 'package:flutter/material.dart';
import 'package:pos/components/addnumberfield.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/components/header_container.dart';
import 'package:provider/provider.dart';

Future<void> addNewLoyalityDialog(BuildContext context) async {
  final _formkey = GlobalKey<FormState>();

  final _loyalityTypeControllerMobile = TextEditingController();

  final _loyalityBonusControllerMobile = TextEditingController();

  String? newLoyalityType;
  String? newLoyalityBonus;

  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 270,
          margin: EdgeInsets.only(bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderContainer(title: 'Add new loyalty'),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 24),
                  child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          // boxHeight,
                          AddTextField(
                            hintText: 'Enter bonus eg. loyalty points',
                            textEditingController:
                                _loyalityTypeControllerMobile,
                            onChanged: (newText) {
                              newLoyalityType = newText;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          AddNumberField(
                            hintText: 'Bonus in %',
                            textEditingController:
                                _loyalityBonusControllerMobile,
                            onChanged: (newCharge) {
                              newLoyalityBonus = newCharge;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondaryButton(
                        title: 'Cancel',
                        onPressed: () {
                          if (_loyalityTypeControllerMobile.text.isEmpty &&
                              _loyalityBonusControllerMobile.text.isEmpty) {
                            Navigator.pop(context);
                          } else {
                            _loyalityTypeControllerMobile.clear();
                            _loyalityBonusControllerMobile.clear();
                          }
                        },
                      ),
                      boxWidth,
                      PrimaryButton(
                        title: 'Save',
                        onPressed: () {
                          if (_formkey.currentState!
                                  .validate() /* _loyalityTypeControllerMobile.text.isNotEmpty &&
                              _loyalityBonusControllerMobile.text.isNotEmpty */
                              ) {
                            Provider.of<SettingController>(context,
                                    listen: false)
                                .addLoyalityMobile(
                                    newLoyalityType!, newLoyalityBonus!);
                            Navigator.pop(context);
                          } else {
                            print('error');
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
