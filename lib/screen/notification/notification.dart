import 'dart:io';

import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/controller/notificationcontroller.dart';
import 'package:pos/screen/addclients/addclients.dart';
import 'package:pos/screen/notificationcreditors/add_notification_creaditors.dart';
import 'package:provider/provider.dart';

class AddNotification extends StatelessWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _con = Provider.of<NotificationController>(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          GestureDetector(
            onTap: () => _con.uploadImage(),
            child: DottedBorder(
              dashPattern: [10, 10],
              color: _con.file != null ? Colors.transparent : Colors.black,
              child: Container(
                alignment: Alignment.center,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _con.file == null ? Colors.white : Colors.transparent,
                ),
                child: _con.file == null
                    ? Center(
                        child: Text(
                          '+ Add Image',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    : (kIsWeb)
                        ? Image.memory(
                            _con.webImage,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(_con.file!.path),
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 23.0),
            child: NotifiactionCustomRow(
              icon: Icons.title,
              label: "Title",
            ),
          ),
          NotifiactionCustomRow(
            icon: Icons.file_present,
            label: "Discription",
            maxLength: 160,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckBoxWithTitle(
                title: 'All',
                value: _con.allNotification[0].value,
                onChanged: (value) {
                  _con.isCheckAll(value);
                },
              ),
              Row(
                children: List.generate(_con.notification.length, (index) {
                  return CheckBoxWithTitle(
                    title: '${_con.notification[index].title}',
                    value: _con.notification[index].value,
                    onChanged: (value) {
                      _con.isSingleCheck(index, value);
                    },
                  );
                }),
              ),
            ],
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 45),
              width: 100,
              child: PrimaryButton(
                title: 'Send',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddClient(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxWithTitle extends StatelessWidget {
  const CheckBoxWithTitle({
    Key? key,
    required this.title,
    required this.value,
    this.onChanged,
  }) : super(key: key);
  final String title;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.7,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
          ),
        ),
        Text(title),
      ],
    );
  }
}

// class CustomTextfieldWithIcon extends StatelessWidget {
//   const CustomTextfieldWithIcon({
//     Key? key,
//     required this.text,
//     required this.icon,
//   }) : super(key: key);

//   final String text;
//   final IconData icon;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Icon(
//               icon,
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Container(
//               child: TextField(
//                 maxLength: 10,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.zero,
//                   labelText: text,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
