import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../Model/friendAdd_model.dart';
import '../services/notification_provider.dart'; // notification service import

class FriendController extends GetxController {
  final Uuid _uuid = Uuid();
  late Box _friendsBox;
  var friendsList = <FriendModel>[].obs;
  var isHiveReady = false.obs; // Hive ready flag

  @override
  void onInit() {
    super.onInit();
    _initHive();
  }

  /// Initialize Hive and load friends
  Future<void> _initHive() async {
    _friendsBox = await Hive.openBox<FriendModel>('friendsBox');
    _loadFriendsFromHive();
    isHiveReady.value = true; // Hive initialized
  }

  /// Load friends from Hive
  void _loadFriendsFromHive() {
    // ✅ Explicitly cast List<dynamic> to List<FriendModel>
    friendsList.assignAll(
      _friendsBox.values.cast<FriendModel>().toList(),
    );
    _sortFriendsList();
  }

  /// Sort friends by upcoming birthday
  void _sortFriendsList() {
    friendsList.sort((a, b) {
      return _calculateEffectiveBirthdayDate(a.birthday)
          .compareTo(_calculateEffectiveBirthdayDate(b.birthday));
    });
  }

  /// Add a new friend
  void addFriend({
    required String name,
    required DateTime birthday,
    String? notes,
  }) {
    if (!isHiveReady.value) {
      Get.snackbar("Please wait", "Database is initializing...");
      return;
    }

    if (name.isEmpty) {
      Get.snackbar("Error", "Name cannot be empty.");
      return;
    }

    final newFriend = FriendModel(
      id: _uuid.v4(),
      name: name,
      birthday: birthday,
      notes: notes,
    );

    _friendsBox.put(newFriend.id, newFriend);
    _loadFriendsFromHive();

    /// Schedule notification 2 days before birthday at 12 AM
    NotificationService.scheduleBirthdayNotification(
      id: newFriend.id.hashCode,
      title: "🎂 Birthday Reminder",
      body: "Today is ${newFriend.name}'s birthday! 🎉",
      birthday: newFriend.birthday!, 
    );

    Get.snackbar("Success", "Friend '${newFriend.name}' added!");
  }

  /// Update an existing friend
  void updateFriend({
    required String id,
    required String name,
    required DateTime birthday,
    String? notes,
  }) {
    if (!isHiveReady.value) {
      Get.snackbar("Please wait", "Database is initializing...");
      return;
    }

    final friendToUpdate = _friendsBox.get(id) as FriendModel?;
    if (friendToUpdate != null) {
      friendToUpdate.name = name;
      friendToUpdate.birthday = birthday;
      friendToUpdate.notes = notes;

      _friendsBox.put(id, friendToUpdate);
      _loadFriendsFromHive();

      /// Reschedule notification
      NotificationService.scheduleBirthdayNotification(
        id: friendToUpdate.id.hashCode,
        title: "🎂 Birthday Reminder",
        body: "Today is ${friendToUpdate.name}'s birthday! 🎉",
        birthday: friendToUpdate.birthday!, // ✅ শুধু birthday পাঠাবেন
      );



      Get.snackbar("Success", "Friend '${friendToUpdate.name}' updated!");
    } else {
      Get.snackbar("Error", "Friend not found.");
    }
  }

  /// Delete a friend
  void deleteFriend(String id) {
    if (!isHiveReady.value) {
      Get.snackbar("Please wait", "Database is initializing...");
      return;
    }

    final friend = _friendsBox.get(id) as FriendModel?;
    if (friend != null) {
      _friendsBox.delete(id);
      friendsList.removeWhere((f) => f.id == id);

      /// Cancel scheduled notification
      NotificationService.cancelNotification(id.hashCode);

      Get.snackbar("Deleted", "Friend '${friend.name}' removed.");
    }
  }

  /// Calculate next upcoming birthday
  DateTime _calculateEffectiveBirthdayDate(DateTime? birthday) {
    if (birthday == null) return DateTime.now();

    final now = DateTime.now();
    final thisYearBirthday = DateTime(now.year, birthday.month, birthday.day);

    if (thisYearBirthday.isBefore(DateTime(now.year, now.month, now.day))) {
      return DateTime(now.year + 1, birthday.month, birthday.day);
    }
    return thisYearBirthday;
  }
}
