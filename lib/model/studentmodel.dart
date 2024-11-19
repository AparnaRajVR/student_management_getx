import 'package:hive_flutter/adapters.dart';

part 'studentmodel.g.dart';

@HiveType(typeId: 0)
class StudentModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  String place;
  @HiveField(2)
  String email;
  @HiveField(3)
  int phone;
  @HiveField(4)
  String imageUrl;

  StudentModel(
      {required this.name,
      required this.place,
      required this.email,
      required this.phone,
      required this.imageUrl});
}
