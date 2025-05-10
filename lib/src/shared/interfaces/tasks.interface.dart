class TasksInterface {
  String title;
  String description;
  int priority;
  int completed;
  int id;

  TasksInterface(
      {required this.title,
      required this.description,
      required this.priority,
      required this.completed,
      required this.id});
}
