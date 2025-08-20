import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';
import 'package:tasks_ia_koderx/src/widgets/TaskContainer/TaskContainer.dart';

class TaskDisplay extends StatefulWidget {
  const TaskDisplay(
      {super.key,
      required this.localTasks,
      required this.onlineTasks,
      required this.changeToPendingTask});
  final List<CreateTasksState> localTasks;
  final List<TasksServer> onlineTasks;
  final void Function(int id, CreateTasksState task) changeToPendingTask;

  @override
  State<TaskDisplay> createState() => _TaskDisplayState();
}

class _TaskDisplayState extends State<TaskDisplay> {
  List<dynamic> tasksUser = [];
  TaskService taskService = TaskService();

  @override
  void initState() {
    super.initState();
    int lastIdOnline = widget.onlineTasks[widget.onlineTasks.length - 1].id_task_app;
    final localMap = {for (var tk in widget.localTasks) tk.id: tk};

    for (var tkOnline in widget.onlineTasks) {
      final tkLocal = localMap[tkOnline.id_task_app];
      if (tkLocal != null) {
        taskService.updateTask(
          UpdateTasksInterface(id: lastIdOnline + 1),
          tkLocal.id!,
        );
      }
    }

    print(widget.localTasks[0].id);

    tasksUser = [...widget.localTasks, ...widget.onlineTasks];
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
                      online: task.runtimeType != CreateTasksState,
                      id: task.runtimeType == CreateTasksState
                          ? task.id
                          : task.id_task_app,
                      completed: task.runtimeType == CreateTasksState
                          ? true
                          : task.completed == 1,
                      title: task.runtimeType == CreateTasksState
                          ? task.title_task
                          : task.title,
                      description: task.description,
                      priority: task.runtimeType == CreateTasksState
                          ? task.value_priority
                          : task.priority,
                      onClick: () =>
                          widget.changeToPendingTask(task.id ?? 0, task),
                    ))
                .toList(),
          ),
        ));
  }
}
