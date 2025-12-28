import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/providers/task_state.dart';
import 'package:tasks_ia_koderx/src/shared/commands/taskCommand.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/payloadsTaskCommand.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

class TaskController extends StateNotifier<TasksState> {
  TaskController() : super(TasksState()) {
    fetchTasksPeriodically();
  }

  Future<void> fetchTasksPeriodically() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      final tasks = await GetTaskCommand().execute();
      state = state.copyWith(tasks: tasks);
    }
  }

  Future<int> updateTask(UpdateTasksInterface task, int id) async {
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
    await CreateTaskCommand()
        .execute(CreateTaskPayload(title, description, priority));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks);
  }

  Future<int> deleteTask(int id) async {
    final result = await DeleteTaskCommand().execute(DeleteTaskPayload(id));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks);
    return result;
  }

  Future<int> deleteSeveralTasks(List<int> ids) async {
    final result =
        await DeleteTaskSeveralCommand().execute(DeleteTaskSeveralPayload(ids));
    final tasks = await GetTaskCommand().execute();
    state = state.copyWith(tasks: tasks, selectedTasks: []);
    return result;
  }

  void clearSelectTasks() {
    state = state.copyWith(selectedTasks: []);
  }

  void assignTasksSelected(List<int> ids) {
    if (state.selectedTasks.isEmpty) {
      state = state.copyWith(selectedTasks: ids);
    } else {
      clearSelectTasks();
    }
  }
}
