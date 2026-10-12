import 'package:hive/hive.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskService {
  static int numberOfcompleted = 0;
  static final box = Hive.box<TaskModel>(AppString.taskBox);

  static List<TaskModel> loadTasks() {
    final tasks = box.values.toList();
    loadCompleted();
    return tasks;
  }

  static void loadCompleted() {
    numberOfcompleted = 0;
    for (var element in box.values.toList()) {
      if (element.status == AppString.completedStatus) numberOfcompleted++;
    }
  }

  static void deleteTask(TaskModel task) {
    task.delete();
  }

  static void updateTask(TaskModel task, String status) {
    task.status = status;
    task.save();
  }
}
