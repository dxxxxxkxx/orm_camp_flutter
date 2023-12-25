import 'package:hive/hive.dart';

part 'to_do.g.dart';

@HiveType(typeId: 0)
class ToDo extends HiveObject {
  @HiveField(0)
  final DateTime dateTime;

  @HiveField(1)
  final String text;

  @HiveField(2)
  bool isDone;

  ToDo({required this.dateTime, required this.text}) : isDone = false;
}
