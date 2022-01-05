import 'package:flutter/material.dart';

class TaxesTile extends StatelessWidget {
  final String? taxTitle;
  final bool? isChecked;
  final Function(bool?)? chechBoxCallback;
  final void Function()? onLongPress;
  final void Function()? onTap;
  // final Function(bool?)? chechBoxCallback;

  TaxesTile(
      {this.taxTitle,
      this.chechBoxCallback,
      this.isChecked,
      this.onLongPress,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      onLongPress: onLongPress,
      leading: Transform.scale(
        scale: 0.7,
        child: Checkbox(
          value: isChecked,
          onChanged: chechBoxCallback,
        ),
      ),
      onTap: onTap,
      title: Text(
        taxTitle!,
      ),
      trailing: PopupOptionMenu(),
    );
  }
}

class PopupOptionMenu extends StatelessWidget {
  const PopupOptionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (item) => onSelected(context, item),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Text('Item 1'),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Text('Item 2'),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Text('Item 3'),
        ),
      ],
    );
  }

  onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        print('item 1 pressed');
        break;
      case 1:
        print('item 2 pressed');
        break;
      case 2:
        print('item 3 pressed');
        break;
    }
  }
}
