import 'package:tasks_ia_koderx/src/shared/States/Tasks/database_helper.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

class TaskService {
  Future<void> saveTasks(String title, String description, int priority) async {
    await DatabaseTasksHelper.instance.insert(title, description, priority);
  }

  Future<List<CreateTasksState>> getTasks() async {
    return await DatabaseTasksHelper.instance.getTasks();
  }

  Future<int> updateTask(CreateTasksState task, int id) async{
    return await DatabaseTasksHelper.instance.update(task, id);
  }

  Future<int> deleteTask(int id) async{
    return await DatabaseTasksHelper.instance.delete(id);
  }

  Future<int> deleteTasks(List<int> ids) async{
    return await DatabaseTasksHelper.instance.delete_several(ids);
  }
}