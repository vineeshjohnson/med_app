import 'package:hive/hive.dart';

part 'departments.g.dart';

@HiveType(typeId: 2)
class Departments {
  @HiveField(0)
  String departs;

  Departments({required this.departs});
}
