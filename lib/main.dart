import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/models/user_model.dart';
import 'package:to_do_app/to_do_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(AppString.userBox);
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>(AppString.taskBox);
  runApp(ToDoApp());
}
