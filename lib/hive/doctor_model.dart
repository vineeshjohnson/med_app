import 'package:hive/hive.dart';

part 'doctor_model.g.dart'; // Add this line

@HiveType(typeId: 0)
class DoctorModel {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String experience;

  @HiveField(4)
  late String imagePath;

  @HiveField(5)
  late bool isFav;
}
