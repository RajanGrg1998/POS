import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pos/model/api_response.dart';
import 'package:pos/model/create_item.dart';
import 'package:pos/model/item.dart';
import 'package:http/http.dart' as http;
import 'package:pos/model/split_option_model.dart';
import 'package:pos/model/update_item.dart';
import 'package:pos/screen/split/completeaction.dart';
import 'package:pos/screen/split/splitscreen.dart';
import 'package:pos/utils/constant.dart';

class ItemsController extends ChangeNotifier {
  TextEditingController _itemQty = TextEditingController();
  TextEditingController get itemQty => _itemQty;

  final GlobalKey<AnimatedListState> itemKey = GlobalKey();

  List<Item> sortedList = [];
  List<Item> _items = [];
  List<Item> _searchedItems = []; //list for search items

  List<Item> get items => _items;
  List<Item> get searchItems => _searchedItems;

  bool isItemLoaded = false;

//filterall
  void filterAll() {
    sortedList = _items;
  }

//filterDiscount
  void filterDiscount() {
    sortedList = _items
        .where((element) =>
            element.categories!.contains('60fd0ef43f6cf413f8b91403'))
        .toList();
    notifyListeners();
  }

// Drinks
  void filterDrinks() {
    sortedList = _items
        .where((element) =>
            element.categories!.contains('60fd0f353f6cf413f8b91406'))
        .toList();
    notifyListeners();
  }

// Snacks
  void filterSnacks() {
    sortedList = _items
        .where((element) =>
            element.categories!.contains('6119e690ede7585a2f75a289'))
        .toList();
    notifyListeners();
  }

  // Alcohol
  void filterAlcohol() {
    sortedList = _items
        .where((element) =>
            element.categories!.contains('611893deede7585a2f75a27c'))
        .toList();
    notifyListeners();
  }

  TextEditingController _serachTextCon = new TextEditingController();
  TextEditingController get serachTextCon => _serachTextCon;

  onSearchTextChanged(String text) async {
    _searchedItems.clear();
    if (text.isEmpty) {
      notifyListeners();
      return;
    }

    _items.forEach((itemDetail) {
      if (itemDetail.name.toUpperCase().contains(text.toUpperCase()) ||
          itemDetail.price.toString().contains(text))
        _searchedItems.add(itemDetail);
    });

    notifyListeners();
  }

  // Future<APIResponse<List<Item>>> getItemsSearch() {
  //   return http
  //       .get(Uri.parse('http://13.58.181.31/api/dalle/products'))
  //       .then((response) {
  //     if (response.statusCode == 200) {
  //       final result = jsonDecode(response.body)['data'];
  //       Iterable list = result['products'];
  //       _items = list.map((model) => Item.fromJson(model)).toList();
  //       notifyListeners();
  //       return APIResponse<List<Item>>(data: _items);
  //     }
  //     notifyListeners();
  //     return APIResponse<List<Item>>(
  //         error: true, errorMessage: 'Error occured');
  //   }).catchError((_) => APIResponse<List<Item>>(
  //           error: true, errorMessage: 'An error ouccured'));
  // }

  Box<Item>? box;

  Future openBox() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    box = await Hive.openBox<Item>('data');
    return;
  }

  Future<List<Item>> fetchItems() async {
    await openBox();
    try {
      if (!isItemLoaded) {
        final response = await http
            .get(Uri.parse('https://api.khajaghar.ml/api/dalle/products'));
        if (response.statusCode == 200) {
          final result = jsonDecode(response.body)['data'];
          Iterable list = result['products'];
          _items = list.map((model) => Item.fromJson(model)).toList();
          await putData(_items);
          isItemLoaded = true;
        } else {
          throw Exception('Failed to load Items');
        }
      }
    } catch (socketException) {
      print('no internet');
    }

    var myMap = box!.toMap().values.toList();
    if (myMap.isEmpty) {
      print('object');
    } else {
      _items = myMap;
    }
    return _items;
  }

  Future putData(List<Item> data) async {
    await box!.clear();
    for (var d in data) {
      box!.add(d);
    }
  }

  Future<List<Item>> addItems() async {
    if (!isItemLoaded) {
      final response = await http
          .get(Uri.parse('https://api.khajaghar.ml/api/dalle/products'));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        Iterable list = result['products'];
        _items = list.map((model) => Item.fromJson(model)).toList();
        isItemLoaded = true;
      } else {
        throw Exception('Failed to load Items');
      }
    }
    return _items;
  }

  /*------Get items------*/

  Future<APIResponse<List<Item>>> getItems() {
    return http
        .get(Uri.parse('https://api.khajaghar.ml/api/dalle/products'))
        .then((response) {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body)['data'];
        Iterable list = result['products'];
        _items = list.map((model) => Item.fromJson(model)).toList();
        notifyListeners();
        return APIResponse<List<Item>>(data: _items);
      }
      notifyListeners();
      return APIResponse<List<Item>>(
          error: true, errorMessage: 'Error occured');
    }).catchError((_) => APIResponse<List<Item>>(
            error: true, errorMessage: 'An error ouccured'));
  }

  /*------Create items------*/

  Future<APIResponse<bool>> creareUser(CreateItem createItem) async {
    return http
        .post(Uri.parse('https://api.khajaghar.ml/api/dalle/products'),
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
            },
            body: json.encode(createItem.toJson()))
        .then((response) {
      if (response.statusCode == 200) {
        print('${response.statusCode} Successfully created');
        notifyListeners();
        return APIResponse<bool>(data: true);
      }
      notifyListeners();
      return APIResponse<bool>(
          error: true, errorMessage: 'An error occured in create');
    }).catchError((_) => APIResponse<bool>(
            error: true, errorMessage: 'An error occured in create'));
  }

  /*------Update items------*/

  Future<APIResponse<bool>> updateItem(String itemID, UpdateItem item) {
    return http
        .put(Uri.parse('https://api.khajaghar.ml/api/dalle/products/$itemID'),
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
            },
            body: json.encode(item.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
            APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  /*------Delete items------*/

  Future<APIResponse<bool>> deleteNote(String item) {
    return http.delete(
      Uri.parse('https://api.khajaghar.ml/api/dalle/products/$item'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  // sad
  File? image;
  ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    } else {
      print('no image selected');
    }
  }

//uoloadImage
  Future<void> uploadImage() async {
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://api.khajaghar.ml/api/dalle/products');

    var reqeutest = http.MultipartRequest('POST', uri);

    var mutliport = new http.MultipartFile('image', stream, length);

    reqeutest.files.add(mutliport);
    var response = await reqeutest.send();

    print('${response.stream.toString()}');

    if (response.statusCode == 200) {
      print('image loaded');
    } else {
      print('image not uploaded');
    }
  }

//add items
  List<TicektItem> _ticketList = [];
  List<TicektItem> get ticketList => _ticketList;

  void addProductToCart(Item item) {
    for (TicektItem ticektItem in _ticketList) {
      if (ticektItem.item!.id == item.id) {
        ticektItem.increment();
        notifyListeners();
        return;
      }
    }
    _ticketList.add(TicektItem(item: item));
    notifyListeners();
  }

//total amount
  double _total = 0;
  double get total => _total;

//setter for total amount
  set total(double total) {
    _total = total;
    notifyListeners();
  }

//returnChange
  double _returnChange = 0.0;
  double get returnChange => _returnChange;

//setter from returnChange
  set returnChange(double total) {
    _returnChange = total;
    notifyListeners();
  }

  TextEditingController _cashReceived = TextEditingController();
  TextEditingController get cashReceived => _cashReceived;

//setter from cashReceived
  set cashReceived(TextEditingController cashReceived) {
    _cashReceived = cashReceived;
    notifyListeners();
  }

//sum of items selected
  void sum() {
    _total = _ticketList.fold(
        0,
        (previoustotal, current) =>
            previoustotal + (current.item!.price * current.quantity));
    notifyListeners();
  }

//increament quantity
  void increase() {
    int currenttotal = int.parse(_itemQty.text);
    currenttotal++;
    _itemQty.text = (currenttotal).toString();
    notifyListeners();
    print(currenttotal);
  }

//decreament quantity
  void decrease() {
    int currenttotal = int.parse(_itemQty.text);
    currenttotal--;
    _itemQty.text = (currenttotal > 0 ? currenttotal : 1).toString();
    notifyListeners();
  }

//on quanitity save
  onSave(TicektItem ticektItem, context) {
    int current = int.parse(_itemQty.text);
    if (current == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Quantity cannot be zero"),
      ));
    } else {
      ticektItem.quantity = int.parse(_itemQty.text);
      _total = _ticketList.fold(
          0,
          (previoustotal, current) =>
              previoustotal + (ticektItem.item!.price * ticektItem.quantity));
      Navigator.pop(context);
    }

    notifyListeners();
  }

//remove index with fade transition
  void removeAtIndex(TicektItem ticektItem, index, Widget widget) {
    _ticketList.remove(ticektItem);
    _total = _total - ticektItem.item!.price * ticektItem.quantity;

    itemKey.currentState!.removeItem(
      index,
      (context, animation) {
        return FadeTransition(
          opacity: CurvedAnimation(
              parent: animation, curve: const Interval(0.5, 1.0)),
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: animation, curve: const Interval(0.0, 1.0)),
            axisAlignment: 0.0,
            child: widget,
          ),
        );
      },
      duration: const Duration(milliseconds: 600),
    );
    print('deleted');
    notifyListeners();
  }

//clear all added _ticketlist
  void clearAllItems() {
    for (var i = 0; i <= _ticketList.length - 1; i++) {
      itemKey.currentState!.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return Container();
      });
    }
    ticketList.clear();
    notifyListeners();
  }

//for cash recieved
  void performTransaction(context) {
    double _cashRec = double.parse(cashReceived.text);

    if (_total <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment is already completed."),
      ));
    } else if (_cashRec >= total) {
      _returnChange = (_cashRec - total);
      notifyListeners();

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CompleteActionPayment(),
      ));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment is complete. Thank you!"),
      ));
      ticketList.clear();
    } else {
      returnChange = _cashRec - total;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Insufficient amount received."),
      ));
    }
    notifyListeners();
  }

//selected person
  int selectedPerson = 2;
  List<TextEditingController> _amountTextCon = [];
  List<TextEditingController> get amountTextCon => _amountTextCon;

  void splitPayment(context) {
    _total > 0
        ? Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Split(),
          ))
        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: kDefaultGreen,
            content: Text('Payment is already completed.'),
          ));
  }

//setter for amountTextCon
  set amountTextCon(List<TextEditingController> amountTextCon) {
    _amountTextCon = amountTextCon;
    notifyListeners();
  }

//increament for add person
  void addPerson() {
    if (selectedPerson >= 2 && selectedPerson <= 9) {
      selectedPerson++;
    }
    notifyListeners();
  }

//decrement for decrease person
  void decreasePerson() {
    if (selectedPerson >= 3) {
      selectedPerson--;
    }
    notifyListeners();
  }

//list ofr payment Option
  List<String> _paymentOptionController = [];
  List<String> get paymentOptionController => _paymentOptionController;

  List<String> paymentOption = ['Cash', 'Card', 'Online', 'Credits'];

  late String selesectpayment = paymentOption[0];

//split pay method
  splitPay(BuildContext context, SplitOptionModel splitOptionModel) {
    if (total == 0) {
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
      } else if (total < splitOptionModel.paidAmount!.toDouble()) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: kDefaultGreen,
          content:
              Text("Payment Unsuccessful, Please enter remaining amount only."),
        ));
      } else if ((total.toDouble() > 0 &&
          total.toDouble() >= splitOptionModel.paidAmount!.toDouble())) {
        total = total - splitOptionModel.paidAmount!.toDouble();
        if (total == 0) {
          for (int i = 0; i < amountTextCon.length; i++) {
            amountTextCon[i].text = '';
          }
          // _cashReceived = 0;
          // returnChange = 0;
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

class TicektItem {
  int quantity;
  final Item? item;

  TicektItem({this.quantity = 1, required this.item});

  void increment() {
    quantity++;
  }
}
