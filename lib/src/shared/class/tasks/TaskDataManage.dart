import 'package:flutter_riverpod/legacy.dart';

class CreateTaskData {
  final String title;
  final String description;
  final int priority;

  CreateTaskData({
    this.title = "",
    this.description = "",
    this.priority = 3,
  });

  CreateTaskData copyWith({
    String? title,
    String? description,
    int? priority,
  }) {
    return CreateTaskData(
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
    );
  }
}

class TaskDataManageNotifier extends StateNotifier<CreateTaskData> {
  TaskDataManageNotifier() : super(CreateTaskData());

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String description) {
    state = state.copyWith(description: description);
  }

  void setPriority(int priority) {
    state = state.copyWith(priority: priority);
  }

  void resetData(){
    state = CreateTaskData();
  }
}

final taskDataManageProvider = StateNotifierProvider<TaskDataManageNotifier, CreateTaskData>((ref) {
  return TaskDataManageNotifier();
});
