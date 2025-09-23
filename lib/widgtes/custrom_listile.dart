import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllaer/FriendController.dart';

class CustromListile extends StatefulWidget {
  const CustromListile({super.key});

  @override
  State<CustromListile> createState() => _CustromListileState();
}

class _CustromListileState extends State<CustromListile> {
  final FriendController friendController = Get.put(FriendController());

  void _showCustomDialog(int index) {
    final TextEditingController nameEditController =
    TextEditingController(text: friendController.friendsList[index].name);
    final TextEditingController birthdayEditController =
    TextEditingController(text: friendController.friendsList[index].birthday);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.purple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Edit Friend",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: TextEditingController(
                    text: friendController.friendsList[index].name,
                  ),
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: TextEditingController(
                    text: friendController.friendsList[index].birthday,
                  ),
                  decoration: InputDecoration(
                    labelText: "Birthday",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      
                      onPressed: () {
                        
                        final String updatedName = nameEditController.text;
                        final String updatedBirthday = birthdayEditController.text;

                        // 2. Optional: Client-side validation
                        if (updatedName.isEmpty || updatedBirthday.isEmpty) {
                          Get.snackbar(
                            "Input Error",
                            "Name and Birthday cannot be empty.",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return; // Don't proceed if validation fails
                        }

                        // 3. Call the controller's update method
                        friendController.updateFriend(
                          name: updatedName,
                          birthday: updatedBirthday,
                          id: '',
                        );

                        // 4. Close the current screen/dialog
                        Get.back();
                      },

                      child: const Text("Update",style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Back",style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: friendController.friendsList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.purple,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friendController.friendsList[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          friendController.friendsList[index].birthday,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey, size: 20),
                    onPressed: () => _showCustomDialog(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
