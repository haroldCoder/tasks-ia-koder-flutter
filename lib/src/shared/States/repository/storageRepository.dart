import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

abstract class StorageRepository {
  Future<int> insert(String title, String description, int priority);
  Future<List<TasksInterface>> getTasks();
  Future<int> update(UpdateTasksInterface task, int id);
  Future<int> delete(int id);
}