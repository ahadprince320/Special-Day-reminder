import 'package:hive/hive.dart';
part 'friendAdd_model.g.dart';

@HiveType(typeId: 0)
class FriendModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  DateTime? birthday;

  @HiveField(3)
  String? notes;

  FriendModel({
    required this.id,
    required this.name,
    this.birthday,
    this.notes,
  });
}
