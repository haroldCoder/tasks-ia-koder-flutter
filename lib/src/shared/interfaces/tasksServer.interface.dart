import 'package:tasks_ia_koderx/src/shared/interfaces/taskBase.interface.dart';

class TasksServer extends TaskBase {
  String title;
  String description;
  int priority;
  int completed;
  int id;
  int userId;
  String id_task_app;

  TasksServer(
      {required this.title,
      required this.description,
      required this.priority,
      required this.completed,
      required this.id,
      required this.userId,
      required this.id_task_app});

  factory TasksServer.fromJson(Map<String, dynamic> json) {
    return TasksServer(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        priority: json['priority'] as int,
        completed: json['completed'] as int,
        userId: json['userId'] as int,
        id_task_app: json['id_task_app'] as String);
  }

  @override
  String get taskId => id_task_app;
}
