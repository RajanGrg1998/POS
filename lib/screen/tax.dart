import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:pos/components/add_button_header.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/screen/widgets/item_dropdown_tax.dart';
import 'package:pos/screen/widgets/taxes_list.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/components/header_container.dart';
import 'package:provider/provider.dart';

class TaxScreen extends StatefulWidget {
  const TaxScreen({Key? key}) : super(key: key);

  @override
  _TaxScreenState createState() => _TaxScreenState();
}

class _TaxScreenState extends State<TaxScreen> {
  int selectedIndex = 0;
  PageController pageController = PageController();
  final _taxTextController = TextEditingController();
  String? newTaxTitle;
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return ExpandablePageView(
      physics: NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        taxList(context),
        addNewTax(context),
      ],
    );
  }

  Container taxList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xffE0E0E0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tax',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AddButtonHeader(
                  buttonOnTap: () {
                    pageController.animateToPage(1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.ease);
                  },
                  iconOnTap: () {
                    var _controller =
                        Provider.of<SettingController>(context, listen: false);
                    _controller.removeTax(_controller.taxs[selectedIndex]);
                  },
                ),
              ],
            ),
          ),
          TaxesList((int index) {
            selectedIndex = index;
          }),
        ],
      ),
    );
  }

  Container addNewTax(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          HeaderContainer(
            title: 'Add new Tax',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              children: [
                AddTextField(
                  hintText: 'Tax name eg. VAT',
                  textEditingController: _taxTextController,
                  validateText: _validate ? 'Value Can\'t Be Empty' : null,
                  onChanged: (newText) {
                    newTaxTitle = newText;
                  },
                ),
                boxHeight,
                AddTextField(hintText: 'Tax rate in %'),
                boxHeight,
                ItemDropDownTax(),
                boxHeight,
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PrimaryButton(
                          title: 'Cancel',
                          onPressed: () {
                            if (_taxTextController.text.isNotEmpty) {
                              _taxTextController.clear();
                            } else {
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            }
                          }),
                      boxWidth,
                      SecondaryButton(
                        title: 'Save',
                        onPressed: () {
                          if (_taxTextController.text.isNotEmpty) {
                            _validate = false;
                            Provider.of<SettingController>(
                              context,
                              listen: false,
                            ).addTax(newTaxTitle!);

                            pageController.animateToPage(0,
                                duration: Duration(milliseconds: 400),
                                curve: Curves.ease);
                          } else {
                            _validate = true;
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
        ],
      ),
    );
  }
}
