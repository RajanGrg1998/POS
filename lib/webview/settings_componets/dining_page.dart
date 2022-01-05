import 'package:flutter/material.dart';
import 'package:pos/components/addtextfield.dart';
import 'package:pos/components/primary_button.dart';
import 'package:pos/components/secondary_button.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/model/diningModel.dart';
import 'package:pos/utils/constant.dart';
import 'package:pos/webview/components/header_container.dart';
import 'package:provider/provider.dart';

class DiningPage extends StatefulWidget {
  const DiningPage({Key? key}) : super(key: key);

  @override
  _DiningPageState createState() => _DiningPageState();
}

PageController pageController = PageController();
final TextEditingController _diningName = TextEditingController();
bool _validate = false;

class _DiningPageState extends State<DiningPage> {
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
          showDiningList(context),
          addDiningList(context),
        ],
      ),
    );
  }

  Container showDiningList(BuildContext context) {
    DiningNotifier diningNotifier =
        Provider.of<DiningNotifier>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderContainer(
            title: 'Dining Options',
            actions: [
              IconButton(
                onPressed: () {
                  var _controller =
                      Provider.of<DiningNotifier>(context, listen: false);
                  _controller.removeDining(_controller.selectedDining!);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
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
              itemCount: diningNotifier.diningDetail.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<DiningNotifier>(
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
                                    value:
                                        notifier.diningDetail[index].isSelected,
                                    activeColor: Color(0xff30B700),
                                    onChanged: (value) {
                                      notifier.selectSingleCheckBox(
                                          value!, index);
                                    },
                                  ),
                                  Text(
                                    notifier.diningDetail[index].diningName,
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

  Container addDiningList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          HeaderContainer(
            title: 'Add new dining option',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddTextField(
                  hintText: 'Enter name eg. delivery',
                  textEditingController: _diningName,
                  validateText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
                boxHeight,
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SecondaryButton(
                          title: 'Cancel',
                          onPressed: () {
                            if (_diningName.text.isNotEmpty) {
                              _diningName.clear();
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
                            if (_diningName.text.isNotEmpty) {
                              _validate = false;
                              Provider.of<DiningNotifier>(context,
                                      listen: false)
                                  .addDining(
                                DiningModel(_diningName.text, false),
                              );
                              pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.ease);
                            } else {
                              _validate = true;
                              print('error');
                            }
                          });
                          _diningName.clear();
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
