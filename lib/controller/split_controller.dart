import 'package:flutter/material.dart';
import 'package:pos/model/split_option_model.dart';
import 'package:pos/screen/split/completeaction.dart';
import 'package:pos/screen/split/splitscreen.dart';
import 'package:pos/utils/constant.dart';

class SplitController extends ChangeNotifier {
  double _totalAmount = 220.0;

  double get totalAmount => _totalAmount;

  set totalAmount(double value) {
    _totalAmount = value;
    notifyListeners();
  }

  double _cashReceived = 250.0;
  double get cashReceived => _cashReceived;

  set cashReceived(double value) {
    _cashReceived = value;
    notifyListeners();
  }

  double _returnChange = 0.0;
  double get returnChange => _returnChange;

  set returnChange(double value) {
    _returnChange = value;
    notifyListeners();
  }

  void splitPayment(context) {
    totalAmount > 0
        ? Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Split(),
          ))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: kDefaultGreen,
            content: Text('Payment is already completed.'),
          ));
  }

  int selectedPerson = 2;

  void addPerson() {
    if (selectedPerson >= 2 && selectedPerson <= 9) {
      selectedPerson++;
    }
    notifyListeners();
  }

  void decreasePerson() {
    if (selectedPerson >= 3) {
      selectedPerson--;
    }
    notifyListeners();
  }

  List<TextEditingController> _amountTextCon = [];
  List<TextEditingController> get amountTextCon => _amountTextCon;

  set amountTextCon(List<TextEditingController> value) {
    _amountTextCon = value;
    notifyListeners();
  }

  List<String> _paymentOptionController = [];
  List<String> get paymentOptionController => _paymentOptionController;

  List<String> paymentOption = ['Cash', 'Card', 'Online', 'Credits'];

  late String selesectpayment = paymentOption[0];

  // transcction

  void performTransaction(context) {
    if (totalAmount <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment is already completed."),
      ));
    } else if (cashReceived >= totalAmount) {
      returnChange = (cashReceived - totalAmount);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment is complete. Thank you!"),
      ));
      totalAmount = 0;
      cashReceived = 0;
      print('object');
    } else {
      returnChange = cashReceived - totalAmount;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Insufficient amount received."),
      ));
    }
    notifyListeners();
  }

  splitPay(BuildContext context, SplitOptionModel splitOptionModel) {
    if (totalAmount == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment Status, Payment is already completed."),
      ));
      print('object');
    } else {
      if (splitOptionModel.paidAmount == 0.0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: kDefaultGreen,
          content: Text("Payment Unsuccessfull, Please enter correct amount."),
        ));
      } else if (totalAmount < splitOptionModel.paidAmount!.toDouble()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: kDefaultGreen,
          content:
              Text("Payment Unsuccessful, Please enter remaining amount only."),
        ));
      } else if ((totalAmount.toDouble() > 0 &&
          totalAmount.toDouble() >= splitOptionModel.paidAmount!.toDouble())) {
        totalAmount = totalAmount - splitOptionModel.paidAmount!.toDouble();
        if (totalAmount == 0) {
          for (int i = 0; i < amountTextCon.length; i++) {
            amountTextCon[i].text = '';
          }
          cashReceived = 0;
          returnChange = 0;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CompleteActionPayment(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: kDefaultGreen,
            content:
                Text("Payment Successful, Payment is complete. Thank you!"),
          ));
        }
      }
    }
    notifyListeners();
  }
}
