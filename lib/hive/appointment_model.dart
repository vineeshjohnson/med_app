import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 3)
class AppointmentModel extends HiveObject {
  @HiveField(0)
  late String username; // New field for username

  @HiveField(1)
  late String doctorName;

  @HiveField(2)
  late String doctorCategory;

  @HiveField(3)
  late String selectedDate;

  @HiveField(4)
  late String selectedTime;

  @HiveField(5)
  late String name;

  @HiveField(6)
  late String mobilenumber;

  AppointmentModel({
    required this.username, // Updated constructor
    required this.doctorName,
    required this.doctorCategory,
    required this.selectedDate,
    required this.selectedTime,
    required this.mobilenumber,
    required this.name,
  });
}
