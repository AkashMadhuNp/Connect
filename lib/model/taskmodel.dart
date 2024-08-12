import 'package:hive/hive.dart';
part 'taskmodel.g.dart';

@HiveType(typeId: 3)
class TaskModel extends HiveObject{
  @HiveField(0)
  String? Tasktitle;
  @HiveField(1)
  String? date;
  @HiveField(2)
  String? startTime;
  @HiveField(3)
  String? endTime;
  @HiveField(4)
  bool? reminder;
  @HiveField(5)
  String? repeat;
  @HiveField(6)
  String? taskNote;
  @HiveField(7)
  String? taskType;
  @HiveField(8)
  bool? isImportant;
  @HiveField(9)
  bool? iscompleted;
  @HiveField(10)
  String? userKey;


  TaskModel({
    required this.Tasktitle,
    required this.date,
    required this.startTime,
    required this.endTime,
     this.reminder,
     this.repeat,
    required this.taskNote,
    required this.taskType,
    required this.isImportant,
    required this.iscompleted,
    required this.userKey
  });
}