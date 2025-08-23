import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';

class TaskDisplay extends StatefulWidget {
  const TaskDisplay(
      {super.key,
      required this.localTasks,
      required this.onlineTasks,
      required this.changeToPendingTask});
  final List<TasksInterface> localTasks;
  final List<TasksServer> onlineTasks;
  final void Function(int id) changeToPendingTask;

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  List<dynamic> tasksUser = [];
  TaskController taskController = TaskController();

  @override
  void initState() {
    super.initState();

    if (widget.onlineTasks.isNotEmpty) {
      int lastIdOnline =
          widget.onlineTasks[widget.onlineTasks.length - 1].id_task_app;
      final localMap = {for (var tk in widget.localTasks) tk.id: tk};

      for (var tkOnline in widget.onlineTasks) {
        final tkLocal = localMap[tkOnline.id_task_app];
        if (tkLocal != null) {
          taskController.updateTask(
            UpdateTasksInterface(id: lastIdOnline + 1),
            tkLocal.id,
          );
        }
      }

      tasksUser = [...widget.localTasks, ...widget.onlineTasks];
    }
    else{
      tasksUser = widget.localTasks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        thumbVisibility: true,
        thickness: 6,
        radius: Radius.circular(10),
        trackVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            spacing: 10,
            children: tasksUser
                .map<Widget>((task) => TaskContainer(
                      online: task.runtimeType != TasksInterface,
                      id: task.runtimeType == TasksInterface
                          ? task.id
                          : task.id_task_app,
                      completed: task.runtimeType == TasksInterface
                          ? true
                          : task.completed == 1,
                      title: task.runtimeType == TasksInterface
                          ? task.title
                          : task.title,
                      description: task.description,
                      priority: task.runtimeType == TasksInterface
                          ? task.priority
                          : task.priority,
                      onClick: () => widget.changeToPendingTask(task.id ?? 0),
                    ))
                .toList(),
          ),
        ));
  }
}
