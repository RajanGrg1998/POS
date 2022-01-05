import 'package:flutter/material.dart';
import 'package:pos/screen/loyality.dart';
import 'package:pos/screen/payment_large.dart';
import 'package:pos/screen/tax.dart';

import 'package:pos/webview/settings_componets/dining_page.dart';
import 'package:pos/webview/settings_componets/features_page.dart';
import 'package:pos/webview/settings_componets/receipt_page.dart';

class SettingsSwitchList extends StatelessWidget {
  const SettingsSwitchList({
    Key? key,
    required this.selectedSettingsindex,
  }) : super(key: key);

  final int selectedSettingsindex;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        switch (selectedSettingsindex) {
          case 0:
            return FeaturesPage();
          case 1:
            return Center(child: Text('Billing & Subscription'));
          case 2:
            return PaymentLargeScreen();
          case 3:
            return LoyalityScreen();
          case 4:
            return TaxScreen();
          case 5:
            return ReceiptPage();
          case 6:
            return DiningPage();
          case 7:
            return Center(child: Text('Stores'));
          case 8:
            return Center(child: Text('POS Devices'));
          default:
        }
        return Container();
      },
    );
  }
}
