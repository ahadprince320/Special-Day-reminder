import 'package:birthday_reminder_app/widgtes/custrom_listile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllaer/FriendController.dart';

class FriendsBirthdayPage extends StatefulWidget {
  const FriendsBirthdayPage({super.key});

  @override
  State<FriendsBirthdayPage> createState() => _FriendsBirthdayPageState();
}

class _FriendsBirthdayPageState extends State<FriendsBirthdayPage> {
  final FriendController friendController = Get.put(FriendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Purple Header Background
          Container(
            color: Colors.purple,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 88.0),
                  child: Text(
                    "Birthday Reminder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // White Rounded Container
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Card (First Friend or Empty State)
                    Obx(() {
                      if (friendController.friendsList.isEmpty) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.cake_sharp,
                                  size: 40, color: Colors.purpleAccent),
                              SizedBox(width: 12),
                              Text(
                                "No Friend Added",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        final firstFriend = friendController.friendsList[0];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.cake_sharp,
                                  size: 40, color: Colors.purpleAccent),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    firstFriend.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    firstFriend.birthday,
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    }),

                    const SizedBox(height: 20),
                    const Text(
                      "Friends’ Birthdays",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Friends list
                    const Expanded(
                      child: CustromListile(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
