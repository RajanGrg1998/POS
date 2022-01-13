import 'package:flutter/material.dart';
import 'package:pos/controller/items_controller.dart';
import 'package:pos/model/split_option_model.dart';
import 'package:pos/utils/constant.dart';
import 'package:provider/provider.dart';

class SplitOptionBody extends StatelessWidget {
  const SplitOptionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var _pay = Provider.of<SplitController>(context);
    var _itemCon = Provider.of<ItemsController>(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      color: kDefaultBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                boxShadow: [kBoxShadow],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BuildItemNumberButton(
                      iconData: Icons.remove,
                      onPress: () {
                        _itemCon.decreasePerson();
                      }),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_itemCon.selectedPerson}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: 'RobotoBold',
                            color: Color(0xFF000000)),
                      ),
                      const Text(
                        'Person(s)',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'RobotoRegular',
                            color: Color(0xFF7A7A7A)),
                      ),
                    ],
                  ),
                  BuildItemNumberButton(
                      iconData: Icons.add,
                      onPress: () {
                        _itemCon.addPerson();
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40.0),
          Flexible(
              child: ListView.builder(
            itemCount: _itemCon.selectedPerson,
            itemBuilder: (context, index) {
              int personCount = index + 1;
              String selectedDropDown = _itemCon.selesectpayment;
              _itemCon.paymentOptionController.add(selectedDropDown);
              _itemCon.amountTextCon.add(TextEditingController());
              return Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Person ${personCount.toString()}',
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'RobotoBold',
                            color: Color(0xFF000000))),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey, // Text colour here
                              width: 1.6, // Underline width
                            ),
                          ),
                        ),
                        child: PaymentMethodDropdown(
                            value: _itemCon.paymentOptionController[index],
                            valueChanged: (newValue) {
                              _itemCon.paymentOptionController[index] =
                                  newValue.toString();
                            },
                            itemsList: _itemCon.paymentOption.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Text(valueItem),
                                ),
                              );
                            }).toList()),
                      ),
                    ),
                    SplitTextFormField(
                        hintText: 'Enter amount',
                        textEditingController: _itemCon.amountTextCon[index]),
                    SizedBox(height: 10.0),
                    PayButton(
                      onPress: () {
                        String amountValue = _itemCon.amountTextCon[index].text;
                        _itemCon.splitPay(
                          context,
                          SplitOptionModel(
                            personNumber: 'Person ${personCount.toString()}',
                            paymentMethod: _itemCon.selesectpayment,
                            paidAmount: amountValue.isEmpty
                                ? 0.0
                                : double.parse(amountValue),
                          ),
                        );
                        // if (_pay.totalAmount == 0) {
                        //   Navigator.of(context).pop();
                        //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //     backgroundColor: kDefaultGreen,
                        //     content: Text('Payment Successful, Payment is complete. Thank you!'),
                        //   ));
                        // }else if () {

                        // }
                      },
                      text: Text(
                        'Pay',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'RobotoRegular',
                            color: Colors.white),
                      ),
                      color: kDefaultGreen,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    SizedBox(height: 25.0),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}

class BuildItemNumberButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPress;

  const BuildItemNumberButton(
      {Key? key, required this.iconData, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 35,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFF707070)),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPress,
        child: Icon(
          iconData,
          color: kIconColor,
        ),
      ),
    );
  }
}

class PaymentMethodDropdown extends StatelessWidget {
  final String value;
  final ValueChanged valueChanged;
  final List<DropdownMenuItem<String>> itemsList;

  const PaymentMethodDropdown(
      {Key? key,
      required this.value,
      required this.valueChanged,
      required this.itemsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: DropdownButton(
        isExpanded: true,
        hint: Text("Select payment"),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        iconSize: 36.0,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        value: value,
        onChanged: valueChanged,
        items: itemsList,
        underline: SizedBox(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      alignedDropdown: true,
    );
  }
}

// split textform

class SplitTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const SplitTextFormField(
      {Key? key, required this.hintText, required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
          fontSize: 14, fontFamily: 'RobotoRegular', color: Color(0xFF000000)),
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        focusColor: Colors.green,
        hintStyle: const TextStyle(
          fontFamily: 'RobotoRegular',
        ),
        hintText: hintText,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF7A7A7A), width: 1.2)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green)),
      ),
      keyboardType: TextInputType.number,
      controller: textEditingController,
    );
  }
}

// paybutton

class PayButton extends StatelessWidget {
  final VoidCallback onPress;
  final Widget text;
  final Color color;
  final EdgeInsetsGeometry padding;
  const PayButton(
      {Key? key,
      required this.onPress,
      required this.text,
      required this.color,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Padding(
        padding: padding,
        child: text,
      ),
      style: TextButton.styleFrom(backgroundColor: color),
    );
  }
}
