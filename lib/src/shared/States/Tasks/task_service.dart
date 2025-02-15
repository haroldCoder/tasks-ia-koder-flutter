import 'dart:convert';
import 'package:tasks_ia_koderx/src/shared/States/Tasks/database_helper.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class TaskService {
  Future<void> saveTasks(String title, String description, int priority) async {
    await DatabaseHelper.instance.insert(title, description, priority);
  }

  Future<List<CreateTasksState>> getTasks() async {
    return await DatabaseHelper.instance.getTasks();
  }
}