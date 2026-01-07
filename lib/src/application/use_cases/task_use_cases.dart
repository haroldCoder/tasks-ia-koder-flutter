import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/domain/models/payloads_task_command_model.dart';
import 'package:tasks_ia_koderx/src/domain/models/update_task_model.dart';
import 'package:tasks_ia_koderx/src/infrastructure/commands/task_command.dart';
import 'package:tasks_ia_koderx/src/providers/task_state.dart';
import 'package:uuid/uuid.dart';

class TaskUseCases extends StateNotifier<TasksState> {
  TaskUseCases() : super(TasksState()) {
    fetchTasksPeriodically();
  }

  Future<void> fetchTasksPeriodically() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      final tasks = await GetTaskCommand().execute();
      state = state.copyWith(tasks: tasks);
    }
  }

  Future<int> updateTask(IUpdateModel task, String id) async {
    final result =
        await UpdateTaskCommand().execute(UpdateTaskPayload(id, task));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(
        tasks: state.tasks.map((t) {
      if (t.id == id) {
        return t.copyWith(completed: task.completed);
      }
      return t;
    }).toList());
    return result;
  }

  Future<void> createTask(
      String title, String description, int priority) async {
    final id = Uuid().v4();

    await CreateTaskCommand()
        .execute(CreateTaskPayload(id, title, description, priority));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks);
  }

  Future<int> deleteTask(String id) async {
    final result = await DeleteTaskCommand().execute(DeleteTaskPayload(id));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks);
    return result;
  }

  Future<int> deleteSeveralTasks(List<String> ids) async {
    final result =
        await DeleteTaskSeveralCommand().execute(DeleteTaskSeveralPayload(ids));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks, selectedTasks: []);
    return result;
  }

  void clearSelectTasks() {
    state = state.copyWith(selectedTasks: []);
  }

  void assignTasksSelected(List<String> ids) {
    if (state.selectedTasks.isEmpty) {
      state = state.copyWith(selectedTasks: ids);
    } else {
      clearSelectTasks();
    }
  }
}
