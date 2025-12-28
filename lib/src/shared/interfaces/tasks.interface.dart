import 'package:tasks_ia_koderx/src/shared/interfaces/taskBase.interface.dart';

class TasksInterface implements TaskBase {
  @override
  String title;
  @override
  String description;
  @override
  int priority;
  @override
  int completed;
  int id;

  TasksInterface(
      {required this.title,
      required this.description,
      required this.priority,
      required this.completed,
      required this.id});

  @override
  int get taskId => id;

  factory TasksInterface.fromMap(Map<String, dynamic> map) {
    return TasksInterface(
      title: map['title_task'],
      description: map['description'],
      priority: map['value_priority'],
      completed: map['complete'],
      id: map['id'],
    );
  }

  TasksInterface copyWith({
    String? title,
    String? description,
    int? priority,
    int? completed,
    int? id,
  }) {
    return TasksInterface(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      id: id ?? this.id,
    );
  }
}
