import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/application/use_cases/task_use_cases.dart';
import 'package:tasks_ia_koderx/src/providers/task_state.dart';

final taskUseCasesProvider = StateNotifierProvider<TaskUseCases, TasksState>((ref) {
  return TaskUseCases();
});
