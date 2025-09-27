import 'package:flutter/material.dart'; import 'package:get/get.dart'; import 'package:hive_flutter/hive_flutter.dart';

import 'Controllaer/FriendController.dart'; import 'Model/friendAdd_model.dart'; import 'buttom_navigation_bar.dart';

Future main() async { WidgetsFlutterBinding.ensureInitialized();

await Hive.initFlutter();

Hive.registerAdapter(FriendModelAdapter());

await Hive.openBox('friendsBox');

Get.put(FriendController());

runApp(const MyApp()); }

class MyApp extends StatelessWidget { const MyApp({super.key});

@override Widget build(BuildContext context) { return GetMaterialApp( debugShowCheckedModeBanner: false, title: 'Birthday Reminder', theme: ThemeData(primarySwatch: Colors.purple), home: const ButtomNavigationBar(), ); } }
