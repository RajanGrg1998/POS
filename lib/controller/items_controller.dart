import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:pos/model/api_response.dart';
import 'package:pos/model/create_item.dart';
import 'package:pos/model/item.dart';
import 'package:http/http.dart' as http;
import 'package:pos/model/update_item.dart';
import 'package:pos/screen/split/completeaction.dart';
import 'package:pos/utils/constant.dart';

enum HomeState { normal, cart }

class ItemsController extends ChangeNotifier {
  // String _cartTag = "";

  // String get cartTag => _cartTag;

  // set cartTag(String value) {
  //   _cartTag = value;
  //   notifyListeners();
  // }

  // HomeState _homeState = HomeState.normal;
  // HomeState get homestate => _homeState;

  // void changeHomeState(HomeState state) {
  //   _homeState = state;
  //   notifyListeners();
  // }

  // void onVerticalGesture(DragUpdateDetails details) {
  //   if (details.primaryDelta! < -0.7) {
  //     changeHomeState(HomeState.cart);
  //     notifyListeners();
  //   } else if (details.primaryDelta! > 12) {
  //     changeHomeState(HomeState.normal);
  //     notifyListeners();
  //   }
  // }

  List<Item> sortedList = [];
  List<Item> _items = [];
  List<Item> _searchedItems = []; //list for search items

  List<Item> get items => _items;
  List<Item> get searchItems => _searchedItems;

  bool isItemLoaded = false;
  void sortByCategory(category) {
    sortedList = _items
        .where((element) => element.categories!.contains(category))
        .toList();
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

  Future<List<Item>> fetchItems() async {
    if (!isItemLoaded) {
      final response =
          await http.get(Uri.parse('http://13.58.181.31/api/dalle/products'));
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

  Future<List<Item>> addItems() async {
    if (!isItemLoaded) {
      final response =
          await http.get(Uri.parse('http://13.58.181.31/api/dalle/products'));
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
        .get(Uri.parse('http://13.58.181.31/api/dalle/products'))
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
        .post(Uri.parse('http://13.58.181.31/api/dalle/products'),
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
        .put(Uri.parse('http://13.58.181.31/api/dalle/products/$itemID'),
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
      Uri.parse('http://13.58.181.31/api/dalle/products/$item'),
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

  Future<void> uploadImage() async {
    var stream = http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('http://13.58.181.31/api/dalle/products');

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

  double _value = 0; //total amount

  double get value => _value;

  set value(double value) {
    _value = value;
    notifyListeners();
  }

  //return chnaged

  double _returnChange = 0.0;
  double get returnChange => _returnChange;

  set returnChange(double value) {
    _returnChange = value;
    notifyListeners();
  }

  //cash recieved

  // double _cashReceived = 250.0;
  // double get cashReceived => _cashReceived;

  // set cashReceived(double value) {
  //   _cashReceived = value;
  //   notifyListeners();
  // }

  TextEditingController _cashReceived = TextEditingController();
  TextEditingController get cashReceived => _cashReceived;

  set cashReceived(TextEditingController value) {
    _cashReceived = value;
    notifyListeners();
  }

  void total() {
    _value = _ticketList.fold(
        0,
        (previousValue, current) =>
            previousValue + (current.item!.price * current.quantity));
    notifyListeners();
  }

  void removeAtIndex(TicektItem ticektItem) {
    _ticketList.remove(ticektItem);

    _value = _value - ticektItem.item!.price * ticektItem.quantity;

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeAll() {
    _ticketList.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  //for cash recieved

  void performTransaction(context) {
    double _cashRec = double.parse(cashReceived.text);

    if (_value <= 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Payment is already completed."),
      ));
    } else if (_cashRec >= value) {
      _returnChange = (_cashRec - value);
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
      returnChange = _cashRec - value;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: kDefaultGreen,
        content: Text("Insufficient amount received."),
      ));
    }
  }

  notifyListeners();
}

class TicektItem {
  int quantity;
  final Item? item;

  TicektItem({this.quantity = 1, required this.item});

  void increment() {
    quantity++;
  }
}
