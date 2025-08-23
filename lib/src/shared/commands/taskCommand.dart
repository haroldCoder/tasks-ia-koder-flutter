import 'package:tasks_ia_koderx/src/shared/States/Tasks/task_service.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/payloadsTaskCommand.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';

abstract class TaskCommandInterface<T, U> {
  U execute([T payload]);
}

class CreateTaskCommand implements TaskCommandInterface<CreateTaskPayload, Future<void>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<void> execute([CreateTaskPayload? payload]) async {
    if (payload == null) return;
    await _taskService.saveTasks(payload.title, payload.description, payload.priority);
  }
}

class GetTaskCommand implements TaskCommandInterface<void, Future<List<dynamic>>> {
  final TaskService _taskService = TaskService.instance;
  @override
  Future<List<TasksInterface>> execute([void payload]) async {
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