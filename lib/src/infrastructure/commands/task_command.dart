import 'package:tasks_ia_koderx/src/domain/models/payloads_task_command_model.dart';
import 'package:tasks_ia_koderx/src/domain/models/task_model.dart';
import 'package:tasks_ia_koderx/src/domain/models/update_task_model.dart';
import 'package:tasks_ia_koderx/src/infrastructure/Tasks/task_service.dart';

abstract class TaskCommandInterface<T, U> {
  U execute([T payload]);
}

class CreateTaskCommand implements TaskCommandInterface<CreateTaskPayload, Future<void>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<void> execute([CreateTaskPayload? payload]) async {
    if (payload == null) return;
    await _taskService.saveTasks(payload.id ,payload.title, payload.description, payload.priority);
  }
}

class GetTaskCommand implements TaskCommandInterface<void, Future<List<dynamic>>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<List<ITaskModel>> execute([void payload]) async {
    return await _taskService.getTasks();
  }
}

class UpdateTaskCommand implements TaskCommandInterface<UpdateTaskPayload, Future<int>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<int> execute([UpdateTaskPayload? payload]) async {
    if (payload == null) return 0;
    return await _taskService.updateTask(payload.updateTasksInterface, payload.id);
  }
}

class DeleteTaskCommand implements TaskCommandInterface<DeleteTaskPayload, Future<int>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<int> execute([DeleteTaskPayload? payload]) async {
    if (payload == null) return 0;
    return await _taskService.deleteTask(payload.id);
  }
}

class DeleteTaskSeveralCommand implements TaskCommandInterface<DeleteTaskSeveralPayload, Future<int>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<int> execute([DeleteTaskSeveralPayload? payload]) async {
    if (payload == null) return 0;
    return await _taskService.deleteTasks(payload.ids);
  }
}