import 'package:flutter/material.dart';
import 'package:to_do_app/models/app_string.dart';
import 'package:to_do_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  final bool showDescription;
  final VoidCallback? onChanged;
  final VoidCallback? onDelete;

  const TaskItem({
    super.key,
    required this.task,
    this.showDescription = true,
    this.onChanged,
    this.onDelete,
  });

  bool get isCompleted => task.status == AppString.completedStatus;

  void toggleTask(bool value) {
    task.status = value ? AppString.completedStatus : AppString.todoStatus;

    task.save();
    onChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: (value) {
                if (value != null) {
                  toggleTask(value);
                }
              },
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: isCompleted ? Colors.grey : null,
                    ),
                  ),
                  if (showDescription) ...[
                    const SizedBox(height: 5),
                    Text(
                      task.taskDescription,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Task options',
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onSelected: (value) {
                if (value == 'delete') {
                  onDelete?.call();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: Colors.red),
                      SizedBox(width: 10),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
