import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:pos/model/customer.dart';

class CustomerController extends ChangeNotifier {
  Customer? toEditCustomer;

  final List<Customer> _customer = [
    Customer(
        email: 'ChelsiKetan99@mail.com',
        name: 'Chelsi Ketan',
        note: 'note',
        phone: '986454564465',
        image: 'image',
        address: 'phokhara'),
    Customer(
        email: 'SonamGurung@mail.com',
        name: 'Sonam Gurung',
        note: 'note',
        phone: '9998882221',
        image: 'image',
        address: 'Pokhara'),
    Customer(
        email: 'AmitShrestha9@mail.com',
        name: 'Amit Shrestha',
        note: 'note',
        phone: '986454564465',
        image: 'image',
        address: 'NayaBazar Pokhara'),
    Customer(
        email: 'rishi99@mail.com',
        name: 'Rishi Ketan',
        note: 'note',
        phone: '123456789',
        image: 'image',
        address: 'phokhara'),
    Customer(
        email: 'rajangrg@mail.com',
        name: 'Rajan Gurung',
        note: 'note',
        phone: '9825010234',
        image: 'image',
        address: 'Pokhara '),
    Customer(
        email: 'hariShrestha9@mail.com',
        name: 'Hari Shrestha',
        note: 'note',
        phone: '986454564465',
        image: 'image',
        address: 'NayaBazar Pokhara'),
  ];
  UnmodifiableListView<Customer> get customers =>
      UnmodifiableListView(_customer);

  void addCustomer(Customer customer) {
    _customer.add(customer);
    notifyListeners();
  }

  void editCustomer(Customer customer) {
    int index = _customer.indexOf(toEditCustomer!);
    _customer[index] = customer;
    notifyListeners();
  }

  UnmodifiableListView<Customer> get searchedCustomer =>
      UnmodifiableListView(_searchedCustomer);
  List<Customer> _searchedCustomer = [];

  onSearchCustomerChanged(String text) async {
    _searchedCustomer.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }
    _customer.forEach((customerDetail) {
      if (customerDetail.name.toUpperCase().contains(text.toUpperCase()) ||
          customerDetail.phone.contains(text))
        _searchedCustomer.add(customerDetail);
    });
    notifyListeners();
  }
}
