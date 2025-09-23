import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../Model/friendAdd_model.dart'; 

class FriendController extends GetxController {
  var friendsList = <FriendModel>[].obs;
  final Uuid _uuid = Uuid(); 

  // --- ADD FRIEND ---
  void addFriend({
    required String name,
    required String birthday, 
    String? notes,
  }) {
    if (name.isNotEmpty && birthday.isNotEmpty) {
      final newFriend = FriendModel(
        id: _uuid.v4(), 
        name: name,
        birthday: birthday,
        notes: notes,
      );

      friendsList.add(newFriend);
      _sortFriendsList(); 

      Get.snackbar("Success", "Friend '${newFriend.name}' added!");
    } else {
      Get.snackbar("Error", "Name and Birthday cannot be empty.");
    }
  }

  // --- UPDATE FRIEND ---
  void updateFriend({
    required String id, 
    required String name,
    required String birthday,
    String? notes,
  }) {
    if (name.isNotEmpty && birthday.isNotEmpty) {
      int index = friendsList.indexWhere((friend) => friend.id == id);
      if (index != -1) {
        // Create an updated friend model
        final updatedFriend = FriendModel(
          id: id, // Keep the original ID
          name: name,
          birthday: birthday,
          notes: notes,
        );
        friendsList[index] = updatedFriend;
        _sortFriendsList(); // Call sort after updating

        Get.snackbar("Success", "Friend '${updatedFriend.name}' updated!");
      } else {
        Get.snackbar("Error", "Friend with ID '$id' not found for update.");
      }
    } else {
      Get.snackbar("Error", "Name and Birthday cannot be empty for update.");
    }
  }

  // --- DELETE FRIEND ---
  void deleteFriend(String id) { // ID of the friend to delete
    int index = friendsList.indexWhere((friend) => friend.id == id);
    if (index != -1) {
      String removedFriendName = friendsList[index].name;
      friendsList.removeAt(index);
      Get.snackbar("Deleted", "Friend '$removedFriendName' removed.");
    } else {
      Get.snackbar("Error", "Friend with ID '$id' not found for deletion.");
    }
  }

  // --- PRIVATE HELPER TO SORT THE LIST ---
  void _sortFriendsList() {
    friendsList.sort((a, b) {
      final aDate = _parseDate(a.birthday);
      final bDate = _parseDate(b.birthday);

      // Your existing sorting logic (sorts by month then day)
      // For more robust "upcoming birthday" sorting, see previous examples
      // that account for the current year.
      if (aDate.month == bDate.month) {
        return aDate.day.compareTo(bDate.day);
      }
      return aDate.month.compareTo(bDate.month);
    });
  }

  // --- DATE PARSING (Your existing method) ---
  DateTime _parseDate(String dateStr) {
    try {
      // যদি format হয় dd-MM-yyyy
      final parts = dateStr.split('-');
      if (parts.length == 3) { 
        return DateTime(2000, int.parse(parts[1]), int.parse(parts[0]));
      } else if (parts.length == 2) { 
        return DateTime(DateTime.now().year, int.parse(parts[1]), int.parse(parts[0]));
      }
    } catch (e) {
      print("Date parse error for '$dateStr': $e");
    }
    return DateTime(1900, 1, 1); 
  }
}
