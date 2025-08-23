import 'package:tasks_ia_koderx/src/shared/interfaces/updateTask.interface.dart';

class CreateTaskPayload {
  final String title;
  final String description;
  final int priority;

  CreateTaskPayload(this.title, this.description, this.priority);
}

class UpdateTaskPayload {
  final int id;
  final UpdateTasksInterface updateTasksInterface;

  UpdateTaskPayload(this.id, this.updateTasksInterface);
}

class DeleteTaskPayload {
  final int id;

  DeleteTaskPayload(this.id);
}

class DeleteTaskSeveralPayload {
  final List<int> ids;

  DeleteTaskSeveralPayload(this.ids);
}