import 'package:flutter/material.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/screen/widgets/mobile_tile.dart';

import 'package:provider/provider.dart';

class MobileTaxList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _controller = Provider.of<SettingController>(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _controller.taxs.length,
      itemBuilder: (context, index) {
        final tax = _controller.taxs[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: MobileTile(
            taxName: tax.taxName!,
            charge: tax.taxCharged!,
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
