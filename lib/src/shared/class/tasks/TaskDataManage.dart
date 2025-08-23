import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';

class TaskDataManage extends TasksInterface {
  TaskDataManage({
    int id = 0,
    int completed = 0,
    String title = "",
    String description = "",
    int priority = 3,
  }) : super(id: id, title: title, description: description, priority: priority, completed: completed);

  void setId(int id) {
    this.id = id;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setPriority(int priority) {
    this.priority = priority;
  }

  void setCompleted(int completed) {
    this.completed = completed;
  }

  void resetData(){
    title = "";
    description = "";
    priority = 3;
  }
}