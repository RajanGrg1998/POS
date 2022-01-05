import 'package:flutter/material.dart';

class CreditorController extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  addItemInTheList(String value1, String value2, String value3) {
    creditorList.add(
      CreditorModel(name: value1, phone: value2, email: value3),
    );
    notifyListeners();
  }

  final List<CreditorModel> creditorList = [
    CreditorModel(
      name: "Chelsi K...",
      phone: "987556321",
      email: "chelsi.k@g...",
    ),
    CreditorModel(
      name: "Chelsi K...",
      phone: "987556321",
      email: "chelsi.k@g...",
    ),
  ];
  bool sort = false;
  onSort() {
    sort = !sort;
    notifyListeners();
  }

  deleteSelected() async {
    if (selectedCreditor.isNotEmpty) {
      List<CreditorModel> temp = [];
      temp.addAll(selectedCreditor);
      for (CreditorModel creditor in temp) {
        creditorList.remove(creditor);
        selectedCreditor.remove(creditor);
        notifyListeners();
      }
    }
  }

  final List<CreditorModel> selectedCreditor = [];

  onSelectRow(bool selected, CreditorModel creditor) {
    if (selected) {
      selectedCreditor.add(creditor);
      notifyListeners();
    } else {
      selectedCreditor.remove(creditor);
      notifyListeners();
    }
  }

  // changeIsCheckValue(CreditorModel creditorModel) {
  //   creditorModel.isCheck = !creditorModel.isCheck!;
  //   notifyListeners();
  // }
}

class CreditorModel {
  String? name;
  String? phone;
  String? email;
  // bool? isCheck;
  CreditorModel({
    this.name,
    this.phone,
    this.email,
    // this.isCheck = false
  });
}
