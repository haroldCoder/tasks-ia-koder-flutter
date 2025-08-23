import 'package:tasks_ia_koderx/src/shared/States/Tasks/database_helper.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

class TaskService {
  static final TaskService _instance = TaskService._internal();

  TaskService._internal();
  
  static TaskService get instance => _instance;

  Future<void> saveTasks(String title, String description, int priority) async {
    await DatabaseTasksHelper.instance.insert(title, description, priority);
  }

  Future<List<TasksInterface>> getTasks() async {
    return await DatabaseTasksHelper.instance.getTasks();
  }

  Future<int> updateTask(UpdateTasksInterface task, int id) async{
    return await DatabaseTasksHelper.instance.update(task, id);
  }

  Future<int> deleteTask(int id) async{
    return await DatabaseTasksHelper.instance.delete(id);
  }

  Future<int> deleteTasks(List<int> ids) async{
    return await DatabaseTasksHelper.instance.deleteSeveral(ids);
  }
}