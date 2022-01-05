import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/utils/constant.dart';

import 'creditor_list.dart';

class AddNotificationCreditors extends StatefulWidget {
  const AddNotificationCreditors({Key? key}) : super(key: key);

  @override
  _AddNotificationCreditorsState createState() =>
      _AddNotificationCreditorsState();
}

class _AddNotificationCreditorsState extends State<AddNotificationCreditors> {
  XFile? file;
  Uint8List webImage = Uint8List(10);

  bool isSingleChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        title: Text(
          'Add Notification',
          style: kAppBarText,
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios_new),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          GestureDetector(
            onTap: uploadImage,
            child: DottedBorder(
              dashPattern: [10, 10],
              color: file != null ? Colors.transparent : Colors.black,
              child: Container(
                alignment: Alignment.center,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: file == null ? Colors.white : Colors.transparent,
                ),
                child: file == null
                    ? Center(
                        child: Text(
                          '+ Add Image',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      )
                    : (kIsWeb)
                        ? Image.memory(
                            webImage,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(file!.path),
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
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CheckBoxWithTitle(title: 'Email', value: false),
              SizedBox(width: 8),
              CheckBoxWithTitle(title: 'Free', value: false),
              SizedBox(width: 8),
              CheckBoxWithTitle(title: 'SMS', value: false),
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
                      builder: (context) => CreditorList(),
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

  uploadImage() async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // var selected = XFile(image.path);

        setState(() {
          file = XFile(image.path);
        });
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          file = XFile(image.path);
          webImage = f;
        });
      }
    }
  }

  // void _showSelectImageDailoge() {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return CupertinoActionSheet(
  //         title: Text('Add photo'),
  //         actions: [
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               _handleImage(source: ImageSource.camera);
  //             },
  //             child: Text('Take photo'),
  //           ),
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               _handleImage(source: ImageSource.gallery);
  //             },
  //             child: Text('Choose from Gallery'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _handleImage({required ImageSource source}) async {
  //   Navigator.pop(context);

  //   XFile? imageFile = await ImagePicker().pickImage(source: source);

  //   if (imageFile != null) {
  //     setState(() {
  //       _image = imageFile;
  //     });
  //   }
  // }
}

class NotifiactionCustomRow extends StatelessWidget {
  const NotifiactionCustomRow({
    Key? key,
    required this.icon,
    required this.label,
    this.contentPadding,
    this.maxLength,
  }) : super(key: key);
  final IconData icon;
  final String label;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 19),
        Expanded(
          child: TextField(
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLength: maxLength ?? null,
            decoration: InputDecoration(
              contentPadding: contentPadding,
              label: Text('$label'),
              labelStyle: TextStyle(
                fontSize: 16,
                color: Color(0xff7A7A7A),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
              ),
            ),
          ),
        )
      ],
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            value: value,
            onChanged: onChanged,
          ),
        ),
        Text(title),
      ],
    );
  }
}
