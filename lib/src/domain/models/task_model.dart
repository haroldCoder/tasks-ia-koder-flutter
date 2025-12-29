import 'package:tasks_ia_koderx/src/domain/entities/task.dart';

class ITaskModel extends Task {
  ITaskModel({
    required super.id,
    required super.title,
    required super.description,
    required super.priority,
    required super.completed,
  });

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
