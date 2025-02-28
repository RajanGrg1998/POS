import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';

class NotificationController extends ChangeNotifier {
  final List<CheckNotificationModel> notification = [
    CheckNotificationModel(title: 'Email'),
    CheckNotificationModel(title: 'App'),
    CheckNotificationModel(title: 'Sms'),
  ];

  final List<CheckNotificationModel> allNotification = [
    CheckNotificationModel(title: 'All'),
  ];

  isSingleCheck(int index, bool? value) {
    notification[index].value = !notification[index].value;
    allNotification.first.value =
        notification.every((element) => element.value);
    notifyListeners();
  }

  isCheckAll(bool? value) {
    allNotification.first.value = value!;
    notification.forEach((notification) => notification.value = value);
    notifyListeners();
  }

//local notification
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          channelDescription: '',
          importance: Importance.max,
          icon: "@mipmap/ic_launcher",
        ),
        iOS: IOSNotificationDetails());
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

// uploading image

  XFile? file;
  Uint8List webImage = Uint8List(10);

  uploadImage() async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        // var selected = XFile(image.path);

        file = XFile(image.path);
        notifyListeners();
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        file = XFile(image.path);
        webImage = f;
        notifyListeners();
      }
    }
  }
}

class CheckNotificationModel {
  final String? title;
  bool value;

  CheckNotificationModel({
    required this.title,
    this.value = false,
  });
}
