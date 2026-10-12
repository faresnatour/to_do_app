import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:to_do_app/widgets/customTextFormField.dart';
import 'package:to_do_app/widgets/custom_elevated_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  bool highPriority = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "New Task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 30),
                CustomTextFormField(
                  title: "Task Name",
                  hintText: "Enter task name please",
                  maxLines: 1,
                  controller: taskNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter task name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                CustomTextFormField(
                  title: "Task Description",
                  hintText: "Enter task description please",
                  maxLines: 5,
                  controller: taskDescriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter task description";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High Priority",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Switch(
                      value: highPriority,
                      onChanged: (value) {
                        setState(() {
                          highPriority = value;
                        });
                      },
                      activeThumbColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade400,
                      splashRadius: 24,
                    ),
                  ],
                ),
                SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CustomElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Hive.box<TaskModel>(AppString.taskBox)
                            .add(
                              TaskModel(
                                taskName: taskNameController.text,
                                taskDescription: taskDescriptionController.text,
                                highPriority: highPriority,
                              ),
                            )
                            .then((value) {
                              Navigator.pop(context);
                            });
                      }
                    },
                    title: "+  Add Task",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
