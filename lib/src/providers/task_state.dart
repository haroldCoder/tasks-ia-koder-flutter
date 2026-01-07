import 'package:tasks_ia_koderx/src/domain/models/task_model.dart';

class TasksState {
  final List<ITaskModel> tasks;
  final List<String> selectedTasks;

  TasksState({
    this.tasks = const [],
    this.selectedTasks = const [],
  });

  TasksState copyWith({
    List<ITaskModel>? tasks,
    List<String>? selectedTasks,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
    );
  }
}
