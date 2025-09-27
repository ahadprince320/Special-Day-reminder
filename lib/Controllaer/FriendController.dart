import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import '../Model/friendAdd_model.dart';

class FriendController extends GetxController {
  final Uuid _uuid = Uuid();
  late Box _friendsBox;
  var friendsList = [].obs;

  @override
  void onInit() {
    super.onInit();
    _initHive();
  }

  Future _initHive() async {
    _friendsBox = await Hive.openBox('friendsBox');
    _loadFriendsFromHive();
  }

  void _loadFriendsFromHive() {
    friendsList.assignAll(_friendsBox.values.whereType().toList());
    _sortFriendsList();
  }

  void _sortFriendsList() {
    friendsList.sort((a, b) {
      return _calculateEffectiveBirthdayDate(
        a.birthday,
      ).compareTo(_calculateEffectiveBirthdayDate(b.birthday));
    });
  }

  /// Add Friend
  void addFriend({
    required String name,
    required DateTime birthday,
    String? notes,
  }) {
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

    Get.snackbar("Success", "Friend '${newFriend.name}' added!");
  }

  /// Update Friend
  void updateFriend({
    required String id,
    required String name,
    required DateTime birthday,
    String? notes,
  }) {
    final friendToUpdate = _friendsBox.get(id);
    if (friendToUpdate != null) {
      friendToUpdate.name = name;
      friendToUpdate.birthday = birthday;
      friendToUpdate.notes = notes;

      _friendsBox.put(id, friendToUpdate);
      _loadFriendsFromHive();

      Get.snackbar("Success", "Friend '${friendToUpdate.name}' updated!");
    } else {
      Get.snackbar("Error", "Friend not found.");
    }
  }

  /// Delete Friend
  void deleteFriend(String id) {
    final friend = _friendsBox.get(id);
    if (friend != null) {
      _friendsBox.delete(id);
      friendsList.removeWhere((f) => f.id == id);
      Get.snackbar("Deleted", "Friend '${friend.name}' removed.");
    }
  }

  /// Calculate next upcoming birthday
  DateTime _calculateEffectiveBirthdayDate(DateTime? birthday) {
    if (birthday == null) {
      return DateTime.now();
    }

    final now = DateTime.now();
    final thisYearBirthday = DateTime(now.year, birthday.month, birthday.day);

    if (thisYearBirthday.isBefore(DateTime(now.year, now.month, now.day))) {
      return DateTime(now.year + 1, birthday.month, birthday.day);
    }
    return thisYearBirthday;
  }
}
