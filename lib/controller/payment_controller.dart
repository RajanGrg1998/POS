import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:pos/model/paymentModel.dart';

class PaymentNotifier extends ChangeNotifier {
  List<PaymentModel> _paymentList = [];
  UnmodifiableListView<PaymentModel> get paymentDetail =>
      UnmodifiableListView(_paymentList);
  // ignore: unused_field
  PaymentModel? _selectedPayment;

  addPayment(PaymentModel paymentModel) {
    _paymentList.add(paymentModel);
    //print(_paymentList);
    notifyListeners();
  }

  void selectSingleCheckBox(bool val, int index) {
    for (PaymentModel items in _paymentList) {
      items.isSelected = false;
    }
    _paymentList[index].isSelected = val;
    _selectedPayment = _paymentList[index];
    // print(_selectedPayment!.paymentType);
    notifyListeners();
  }

  // List<Widget> splitWidget = [
  //   SplitPersonContainer(
  //     number: 0,
  //     textField: AddTextField(
  //       hintText: '110.00',
  //     ),
  //     onChanged: () {},
  //     onPressed: () {},
  //   )
  // ];

  // addSplitWidget(Widget widget) {
  //   splitWidget.add(widget);
  //   notifyListeners();
  // }

  // removeSplitWidget() {
  //   if (splitWidget.length > 0) {
  //     splitWidget.removeLast();
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  // count() {
  //   splitWidget.length;
  // }
}

// class Splitwidget {
//   Widget widget;
//   Splitwidget({required this.widget});
// }
