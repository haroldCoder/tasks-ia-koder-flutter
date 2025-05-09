class TasksInterface {
  String title;
  String description;
  int priority;
  int completed;

  TasksInterface(
      {required this.title,
      required this.description,
      required this.priority,
      required this.completed});
}
