import 'package:flutter/material.dart';
import 'package:pos/controller/customer_controller.dart';
import 'package:pos/controller/settings_controller.dart';
import 'package:pos/screen/homepage.dart';
import 'package:provider/provider.dart';

import 'controller/client_controller.dart';
import 'controller/creditor_controller.dart';
import 'controller/items_controller.dart';
import 'controller/notificationcontroller.dart';
import 'controller/payment_controller.dart';
import 'controller/sidenav_controller.dart';
import 'controller/split_controller.dart';
import 'controller/storesController.dart';
import 'controller/ticket.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CustomerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SettingController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SideNavController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DiningNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => PaymentNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoreController(),
        ),
        ChangeNotifierProvider(
          create: (_) => TicketProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CreditorController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ClientController(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ItemsController(),
        ),
        ChangeNotifierProvider(
          create: (_) => SplitController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Roboto',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
            foregroundColor: Colors.black,
            // titleTextStyle: TextStyle(color: Colors.red),
          ),
          primarySwatch: Colors.blue,
        ),
        home: Homepage(),
      ),
    );
  }
}
