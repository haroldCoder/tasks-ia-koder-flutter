import 'TaskState.dart';

class TaskError extends TaskState {
  final String message;
  TaskError(this.message);
}