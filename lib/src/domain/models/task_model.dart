import 'package:tasks_ia_koderx/src/domain/models/task_base_model.dart';

class ITaskModel implements ITaskBase {
  @override
  String title;
  @override
  String description;
  @override
  int priority;
  @override
  int completed;
  String id;

  ITaskModel(
      {required this.title,
      required this.description,
      required this.priority,
      required this.completed,
      required this.id});

  @override
  String get taskId => id;

  factory ITaskModel.fromMap(Map<String, dynamic> map) {
    return ITaskModel(
      title: map['title_task'],
      description: map['description'],
      priority: map['value_priority'],
      completed: map['complete'],
      id: map['id'],
    );
  }

  ITaskModel copyWith({
    String? title,
    String? description,
    int? priority,
    int? completed,
    String? id,
  }) {
    return ITaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      id: id ?? this.id,
    );
  }
}
