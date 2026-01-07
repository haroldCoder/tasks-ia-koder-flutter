import 'package:tasks_ia_koderx/src/domain/models/update_task_model.dart';

class CreateTaskPayload {
  final String id;
  final String title;
  final String description;
  final int priority;

  CreateTaskPayload(this.id, this.title, this.description, this.priority);
}

class UpdateTaskPayload {
  final String id;
  final IUpdateModel updateTasksInterface;

  UpdateTaskPayload(this.id, this.updateTasksInterface);
}

class DeleteTaskPayload {
  final String id;

  DeleteTaskPayload(this.id);
}

class DeleteTaskSeveralPayload {
  final List<String> ids;

  DeleteTaskSeveralPayload(this.ids);
}