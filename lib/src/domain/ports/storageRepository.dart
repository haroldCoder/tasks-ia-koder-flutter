import 'package:tasks_ia_koderx/src/domain/models/task_model.dart';
import 'package:tasks_ia_koderx/src/domain/models/update_task_model.dart';

abstract class StorageRepository {
  Future<int> insert(String id, String title, String description, int priority);
  Future<List<ITaskModel>> getTasks();
  Future<int> update(IUpdateModel task, String id);
  Future<int> delete(String id);
}