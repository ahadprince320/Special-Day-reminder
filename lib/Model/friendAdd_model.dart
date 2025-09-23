class FriendModel { 
  String name;
  String birthday; 
  String? notes;  
  String? id;     

  FriendModel({
    required this.name,
    required this.birthday,
    this.notes,
    this.id, 
  });

  // --- Optional: Methods for JSON serialization/deserialization ---
  // Useful if you ever connect to an API or want to store as JSON locally (not Hive)

  // --- Optional: Placeholder for Hive Integration (if you decide later) ---
  /*
  // To use with Hive, you would:
  // 1. Add Hive annotations:
  //    @HiveType(typeId: 0) // Ensure typeId is unique across your Hive models
  //    class FriendModel extends HiveObject { // Extend HiveObject for auto-keys
  //
  //      @HiveField(0)
  //      String name;
  //
  //      @HiveField(1)
  //      String birthday;
  //
  //      @HiveField(2)
  //      String? notes;
  //
  //      // id might not be needed as a separate HiveField if extending HiveObject,
  //      // as HiveObject provides an auto-incrementing 'key'.
  //
  //      FriendModel({required this.name, required this.birthday, this.notes});
  //    }
  // 2. Generate the adapter using build_runner.
  */

  @override
  String toString() {
    return 'FriendModel(id: $id, name: $name, birthday: $birthday, notes: $notes)';
  }
}
