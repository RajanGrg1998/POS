import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/payment_controller.dart';
import 'package:pos/model/paymentModel.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Payment', style: kAppBarText),
      ),
      body: _paymentContent(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 30.0,
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xff30B700),
          onPressed: () {
            addPayment(context);
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget _paymentContent() {
    PaymentNotifier paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: true);
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: paymentNotifier.paymentDetail.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<PaymentNotifier>(
                builder: (context, notifier, child) {
                  return Row(
                    children: [
                      Checkbox(
                        value: notifier.paymentDetail[index].isSelected,
                        activeColor: Color(0xff30B700),
                        onChanged: (value) {
                          notifier.selectSingleCheckBox(value!, index);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          child: notifier.paymentDetail[index].image,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        child: Text(
                          notifier.paymentDetail[index].paymentType,
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Divider(
                color: Color(0xffE0E0E0),
                thickness: 1.0,
              ),
            ],
          );
        },
      ),
    );
  }

  void addPayment(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialogeComponent();
        });
  }
}

class AlertDialogeComponent extends StatefulWidget {
  const AlertDialogeComponent({Key? key}) : super(key: key);

  @override
  _AlertDialogeComponentState createState() => _AlertDialogeComponentState();
}

class _AlertDialogeComponentState extends State<AlertDialogeComponent> {
  final TextEditingController _paymentTypeName = TextEditingController();

  XFile? _imageFile;
  Uint8List webImage = Uint8List(10);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    PaymentNotifier paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      titlePadding: EdgeInsets.zero,
      scrollable: true,
      contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
      title: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Text(
          'Make Payment',
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 0.8, color: Color(0xffE0E0E0)),
          ),
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Add Payment Type',
              ),
              controller: _paymentTypeName,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please add payment type';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 26.0,
              ),
              child: Text(
                'Choose Picture',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 170.0,
              padding: const EdgeInsets.only(top: 8.5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffE0E0E0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: takeImage,
                // onPressed: () {

                //   showModalBottomSheet(
                //     context: context,
                //     builder: (builder) => bottomSheet(context),
                //   );
                // },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: Container(
                height: 80.0,
                width: 80.0,
                child: _imageFile == null
                    ? Container()
                    : (kIsWeb)
                        ? Image.memory(
                            webImage,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                          ),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SecondaryButton(
                title: 'Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all<Color>(
              //       Colors.black.withOpacity(0.08),
              //     ),
              //   ),
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: Text(
              //     'Cancel',
              //   style: TextStyle(
              //       fontSize: 14.0,
              //       fontWeight: FontWeight.normal,
              //       color: Colors.black),
              // ),
              // ),
              SizedBox(
                width: 15.0,
              ),
              PrimaryButton(
                title: 'Save',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final addPayment = _paymentTypeName.text;
                    if (_imageFile != null) {
                      setState(
                        () {
                          paymentNotifier.addPayment(PaymentModel(
                            addPayment,
                            kIsWeb
                                ? Image.memory(
                                    webImage,
                                    fit: BoxFit.contain,
                                  )
                                : Image.file(
                                    File(_imageFile!.path),
                                  ),
                            false,
                          ));
                        },
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment Type added Sucessfully'),
                          backgroundColor: kDefaultGreen,
                        ),
                      );
                    } else
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please upload image as well'),
                          backgroundColor: kDefaultGreen,
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  takeImage() async {
    // using kIsWeb to detect if it is runmning in web or not
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          _imageFile = XFile(image.path);
          print(_imageFile!.path.toString());
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
          _imageFile = XFile(image.path);
          webImage = f;
        });
      }
    }
  }

  // void takePhoto(ImageSource source) async {
  //   final _pickedFile = await _picker.pickImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _imageFile = _pickedFile;
  //   });
  // }

  // Widget bottomSheet(BuildContext context) {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           "Choose image",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20.0,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(
  //                   Colors.grey.shade300,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 takePhoto(ImageSource.camera);
  //                 Navigator.pop(context);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.camera_alt,
  //                     color: Colors.black,
  //                   ),
  //                   SizedBox(
  //                     width: 7.0,
  //                   ),
  //                   Text(
  //                     'Camera',
  //                     style: TextStyle(
  //                       fontSize: 16.0,
  //                       color: Colors.black,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Spacer(),
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 backgroundColor: MaterialStateProperty.all<Color>(
  //                   Colors.grey.shade300,
  //                 ),
  //               ),
  //               onPressed: () {
  //                 takePhoto(ImageSource.gallery);
  //                 Navigator.pop(context);
  //               },
  //               child: Row(
  //                 children: [
  //                   Icon(
  //                     Icons.image,
  //                     color: Colors.black,
  //                   ),
  //                   SizedBox(
  //                     width: 7.0,
  //                   ),
  //                   Text(
  //                     'Gallery',
  //                     style: TextStyle(
  //                       fontSize: 16.0,
  //                       color: Colors.black,
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
