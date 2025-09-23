import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:birthday_reminder_app/widgtes/custromapp-bar.dart';

import '../Controllaer/FriendController.dart';

class AddFriendPage extends StatelessWidget {
  AddFriendPage({super.key});

  final FriendController friendController = Get.put(FriendController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custromappbar( 
        title: Text('Add Friend Here'),
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
                    labelText: " জন্মদিন / গুরুত্বপূর্ণ তারিখ ",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_outlined), 
                  ),
                  readOnly: true, 
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());

                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900), // Sensible earliest date for a birthday
                      lastDate: DateTime.now().add(Duration(days: 365 * 5)), // Allow future dates for other important events
                      helpText: 'Select Birthday / Important Date',
                    );

                    if (pickedDate != null) {
                      String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      dateController.text = formattedDate;
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
                  final String name = nameController.text;
                  final String birthday = dateController.text;
                  friendController.addFriend(
                    name: name,
                    birthday: birthday,
                  );
                  if (name.isNotEmpty && birthday.isNotEmpty) { // Basic check
                    nameController.clear();
                    dateController.clear();
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

