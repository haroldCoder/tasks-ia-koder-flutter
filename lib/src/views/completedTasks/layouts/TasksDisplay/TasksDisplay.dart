import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/taskBase.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';

class TaskDisplay extends StatelessWidget {
  const TaskDisplay(
      {super.key,
      required this.localTasks,
      required this.onlineTasks,
      required this.changeToPendingTask});
  final List<TasksInterface> localTasks;
  final List<TasksServer> onlineTasks;
  final void Function(String id) changeToPendingTask;


  @override
  Widget build(BuildContext context) {
    final List<TaskBase> tasksUser = onlineTasks.isNotEmpty
        ? [...localTasks, ...onlineTasks]
        : localTasks;

    return Scrollbar(
      thumbVisibility: true,
      thickness: 6,
      radius: const Radius.circular(10),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          spacing: 25,
          children: tasksUser.map((task) {
            final isLocal = task is TasksInterface;

            return TaskContainer(
              online: !isLocal,
              id: task.taskId,
              completed: isLocal ? true : task.completed == 1,
              title: task.title,
              description: task.description,
              priority: task.priority,
              onClick: () =>
                  changeToPendingTask(task.taskId),
            );
          }).toList(),
        ),
      ),
    );
  }
}
