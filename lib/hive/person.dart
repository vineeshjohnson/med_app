import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  Person(
      {required this.email,
      required this.password,
      required this.name,
      required this.mobileNumber});

  @HiveField(0)
  String email;

  @HiveField(1)
  String password;

  @HiveField(2)
  String name;

  @HiveField(3)
  String mobileNumber;
}
