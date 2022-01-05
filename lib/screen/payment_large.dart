import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/payment_controller.dart';
import 'package:pos/model/paymentModel.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/components/header_container.dart';
import 'package:provider/provider.dart';

class PaymentLargeScreen extends StatefulWidget {
  const PaymentLargeScreen({Key? key}) : super(key: key);

  @override
  _PaymentLargeScreenState createState() => _PaymentLargeScreenState();
}

class _PaymentLargeScreenState extends State<PaymentLargeScreen> {
  bool _validate = false;
  final TextEditingController _paymentTypeName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  int selectedIndex = 0;

  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    _paymentTypeName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 300,
        minWidth: 500,
        maxWidth: 600,
        maxHeight: 500,
      ),
      // height: 300,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          showPaymentList(context),
          addNewPayment(context),
        ],
      ),
    );
  }

  Container showPaymentList(BuildContext context) {
    PaymentNotifier paymentNotifier =
        Provider.of<PaymentNotifier>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderContainer(
            title: 'Add Payment',
            actions: [
              PrimaryButton(
                title: 'Add New',
                icon: Icon(
                  Icons.add,
                  size: 16,
                ),
                onPressed: () {
                  pageController.animateToPage(1,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.ease);
                },
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: paymentNotifier.paymentDetail.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<PaymentNotifier>(
                      builder: (context, notifier, child) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: notifier
                                        .paymentDetail[index].isSelected,
                                    activeColor: Color(0xff30B700),
                                    onChanged: (value) {
                                      notifier.selectSingleCheckBox(
                                          value!, index);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      child:
                                          notifier.paymentDetail[index].image,
                                    ),
                                  ),
                                  Text(
                                    notifier.paymentDetail[index].paymentType,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.more_vert),
                              ),
                            ],
                          ),
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
          ),
        ],
      ),
    );
  }

  Container addNewPayment(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          HeaderContainer(
            title: 'Add new Payment',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddTextField(
                  hintText: 'Esewa',
                  textEditingController: _paymentTypeName,
                  validateText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                boxHeight,
                Text('Choose Picture'),
                boxHeight,
                SizedBox(
                  width: 150,
                  child: SecondaryButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      title: 'Upload Image',
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (builder) => Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Choose image",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SecondaryButton(
                                      title: 'Camera',
                                      onPressed: () {
                                        takePhoto(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                    SecondaryButton(
                                      title: 'Gallery',
                                      onPressed: () {
                                        takePhoto(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.image,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                boxHeight,
                Container(
                  height: 80.0,
                  width: 80.0,
                  child: _imageFile == null
                      ? Container()
                      : Image.file(
                          File(_imageFile!.path),
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondaryButton(
                          title: 'Cancel',
                          onPressed: () {
                            if (_paymentTypeName.text.isNotEmpty) {
                              _paymentTypeName.clear();
                            } else {
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            }
                          }),
                      boxWidth,
                      PrimaryButton(
                        title: 'Save',
                        onPressed: () {
                          setState(() {
                            if (_paymentTypeName.text.isNotEmpty) {
                              _validate = false;
                              Provider.of<PaymentNotifier>(context,
                                      listen: false)
                                  .addPayment(
                                PaymentModel(
                                  _paymentTypeName.text,
                                  Image.file(
                                    File(_imageFile!.path),
                                  ),
                                  false,
                                ),
                              );
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            } else {
                              _validate = true;
                              print('error');
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final _pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = _pickedFile;
    });
  }
}
