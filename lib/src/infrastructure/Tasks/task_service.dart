import 'package:tasks_ia_koderx/src/domain/models/task_model.dart';
import 'package:tasks_ia_koderx/src/domain/models/update_task_model.dart';
import 'package:tasks_ia_koderx/src/infrastructure/Tasks/database_helper.dart';

class TaskService {
  static final TaskService _instance = TaskService._internal();

  TaskService._internal();
  
  static TaskService get instance => _instance;

  Future<void> saveTasks(String id, String title, String description, int priority) async {
    await DatabaseTasksHelper.instance.insert(id, title, description, priority);
  }

  Future<List<ITaskModel>> getTasks() async {
    return await DatabaseTasksHelper.instance.getTasks();
  }

  Future<int> updateTask(IUpdateModel task, String id) async{
    return await DatabaseTasksHelper.instance.update(task, id);
  }

  Future<int> deleteTask(String id) async{
    return await DatabaseTasksHelper.instance.delete(id);
  }

  Future<int> deleteTasks(List<String> ids) async{
    return await DatabaseTasksHelper.instance.deleteSeveral(ids);
  }
}