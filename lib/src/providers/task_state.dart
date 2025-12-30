import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';

class TasksState {
  final List<TasksInterface> tasks;
  final List<String> selectedTasks;

  TasksState({
    this.tasks = const [],
    this.selectedTasks = const [],
  });

  TasksState copyWith({
    List<TasksInterface>? tasks,
    List<String>? selectedTasks,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
    );
  }
}
