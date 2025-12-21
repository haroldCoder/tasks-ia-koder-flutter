import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/providers/task_state.dart';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/TaskController.dart';

final taskProvider = StateNotifierProvider<TaskController, TasksState>((ref) {
  return TaskController();
});

