import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  String taskDescription;

  @HiveField(2)
  bool highPriority;
  @HiveField(3)
  String status;
  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.highPriority,
    this.status = "todo",
  });
}
