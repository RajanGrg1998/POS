import 'package:flutter/material.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:provider/provider.dart';

import '../widgets/mobile_tile.dart';

class MobileLoyalityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingController>(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _controller.loyality.length,
      itemBuilder: (context, index) {
        final tax = _controller.loyality[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: MobileTile(
            taxName: tax.type!,
            charge: tax.bonus!,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Divider(
            thickness: 1.5,
            color: Color(0xffE0E0E0),
          ),
        );
      },
    );
  }
}
