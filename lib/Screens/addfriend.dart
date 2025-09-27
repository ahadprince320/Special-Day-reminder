import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:birthday_reminder_app/widgtes/custromapp-bar.dart';

import '../Controllaer/FriendController.dart';

class AddFriendPage extends StatefulWidget {
  const AddFriendPage({super.key});

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  final FriendController friendController = Get.put(FriendController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime? selectedDate; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custromappbar(
        title: const Text('Add Friend Here'),
        toolbarHeight: 180,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "নাম", // "Name"
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "জন্মদিন / গুরুত্বপূর্ণ তারিখ",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  readOnly: true,
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365 * 5),
                      ),
                      helpText: 'Select Birthday / Important Date',
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate; 
                        dateController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final String name = nameController.text.trim();

                  if (name.isNotEmpty && selectedDate != null) {
                    friendController.addFriend(
                      name: name,
                      birthday: selectedDate!,
                    );

                    // Clear fields
                    nameController.clear();
                    dateController.clear();
                    setState(() {
                      selectedDate = null;
                    });

                    Get.snackbar("Saved ✅", "Friend added successfully",
                        snackPosition: SnackPosition.BOTTOM);
                  } else {
                    Get.snackbar("Error ⚠️", "Please enter all details",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: const Text(
                  "সংরক্ষণ",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
