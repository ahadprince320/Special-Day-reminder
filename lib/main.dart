import 'package:birthday_reminder_app/services/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Controllaer/FriendController.dart';
import 'Model/friendAdd_model.dart';
import 'buttom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(FriendModelAdapter());
  await Hive.openBox<FriendModel>('friendsBox');

  await NotificationService.init(); // ✅ Notification init

  Get.put(FriendController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Special Day Reminder',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const ButtomNavigationBar(),
    );
  }
}
