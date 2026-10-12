import 'package:flutter/material.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/task_service.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/home_screen.dart';
import 'package:to_do_app/screens/profile_screen.dart';
import 'package:to_do_app/screens/todo_screen.dart';
import 'package:to_do_app/widgets/bottom_nav_bar.dart';
import 'package:to_do_app/widgets/task_item.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  TaskModel? box;
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    tasks = TaskService.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 15),

            Center(
              child: Text(
                "Completed Tasks",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks
                  .where((task) => task.status == AppString.completedStatus)
                  .length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                tasks
                    .where((task) => task.status == AppString.completedStatus)
                    .toList()[index];

                return TaskItem(
                  showDescription: false,
                  task: tasks
                      .where((task) => task.status == AppString.completedStatus)
                      .toList()[index],
                  onChanged: () {
                    setState(() {
                      tasks = TaskService.loadTasks();
                    });
                  },
                  onDelete: () {
                    TaskService.deleteTask(
                      tasks
                          .where(
                            (task) => task.status == AppString.completedStatus,
                          )
                          .toList()[index],
                    );
                    setState(() {
                      tasks = TaskService.loadTasks();
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TodoScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          }
        },
      ),
    );
  }
}
