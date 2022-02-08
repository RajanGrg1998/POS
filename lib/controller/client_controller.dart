import 'package:flutter/cupertino.dart';

class ClientController extends ChangeNotifier {
  final clientController = TextEditingController();
  final List<ClientModel> creditorList = [
    ClientModel(
      name: "Chelsi Khetan.",
      phone: "987556321",
      email: 'chelsi.k@gmail.com',
    ),
    ClientModel(
      name: "Angel Gurung",
      phone: "987556321",
      email: 'angel.g@gmail.com',
    ),
    ClientModel(
      name: "Johannes Mike",
      phone: "987556321",
      email: 'mike.j@gmail.com',
    ),
    ClientModel(
        name: "Hari Shrestha",
        phone: "987556321",
        email: 'shrestha.hari@gmail.com'),
    ClientModel(
        name: "Nina Dobrev", phone: "987556321", email: 'nina.d@gmai.com'),
    ClientModel(
        name: "Kirshna Paudel",
        phone: "987556321",
        email: 'kirshna.p@gmail.com'),
    ClientModel(
      name: "Bhim Gurung",
      phone: "987556321",
      email: 'bhim.g@gmail.com',
    ),
    ClientModel(
      name: "Sita Magar",
      phone: "987556321",
      email: 'sita.m@gmail.com',
    ),
  ];

  bool sort = false;
  onSort() {
    sort = !sort;
    notifyListeners();
  }

  deleteSelected() async {
    if (selectedUser.isNotEmpty) {
      List<ClientModel> temp = [];
      temp.addAll(selectedUser);
      for (ClientModel client in temp) {
        creditorList.remove(client);
        selectedUser.remove(client);
        notifyListeners();
      }
    }
  }

  final List<ClientModel> selectedUser = [];

  onSelectRow(bool selected, ClientModel user) {
    if (selected) {
      selectedUser.add(user);
      notifyListeners();
    } else {
      selectedUser.remove(user);
      notifyListeners();
    }
  }
}

class ClientModel {
  String? name;
  String? phone;
  String? email;

  ClientModel({this.name, this.phone, this.email});
  @override
  String toString() {
    return '$name';
  }
}
