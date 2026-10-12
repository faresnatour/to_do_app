import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/screens/add_task_screen.dart';
import 'package:to_do_app/screens/completed_screen.dart';
import 'package:to_do_app/screens/profile_screen.dart';
import 'package:to_do_app/screens/todo_screen.dart';
import 'package:to_do_app/widgets/home_appbar.dart';
import 'package:to_do_app/widgets/task_item.dart';
import 'package:to_do_app/widgets/bottom_nav_bar.dart';
import 'package:to_do_app/models/task_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //for handel the tasks
  TaskModel? box;
  double percent = 0;
  List<TaskModel> tasks = [];
  @override
  void initState() {
    super.initState();
    tasks = TaskService.loadTasks();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          setState(() {
            TaskService.loadTasks();
          });
        },
        label: Text(
          "Add New Task",
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        icon: Icon(
          Icons.add,
          size: 17,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListView(
            children: [
              Text(
                "Yuhuu ,Your work Is \nalmost done ! 👋🏻",
                style: TextStyle(fontSize: 35),
              ),
              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(183, 250, 249, 246),
                  border: Border.all(width: 0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Achieved Tasks",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${TaskService.numberOfcompleted} Out of ${tasks.length} Done",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      CircularPercentIndicator(
                        radius: 25,
                        percent: percent = tasks.isEmpty
                            ? 0.0
                            : TaskService.numberOfcompleted / tasks.length,
                        center: Text(
                          "${(percent * 100).toInt()}%",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        progressColor: Colors.green,
                        backgroundColor: Colors.grey.shade300,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color.fromARGB(183, 250, 249, 246),
                  border: Border.all(color: Colors.black, width: 0.2),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "High Priority Tasks",
                        style: TextStyle(
                          color: Color(0xff15B86C),

                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tasks
                            .where((task) => task.highPriority)
                            .length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          tasks
                              .where((task) => task.highPriority)
                              .toList()[index];

                          return TaskItem(
                            showDescription: false,
                            task: tasks
                                .where((task) => task.highPriority)
                                .toList()[index],
                            onChanged: () {
                              setState(() {
                                tasks = TaskService.loadTasks();
                              });
                            },
                            onDelete: () {
                              TaskService.deleteTask(
                                tasks
                                    .where((task) => task.highPriority)
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
              ),
              SizedBox(height: 20),

              Text(
                "My Tasks",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasks.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  tasks.toList()[index];

                  return TaskItem(
                    showDescription: true,
                    task: tasks.toList()[index],
                    onChanged: () {
                      setState(() {
                        TaskService.loadTasks();
                      });
                    },
                    onDelete: () {
                      TaskService.deleteTask(tasks.toList()[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TodoScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CompletedScreen()),
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
