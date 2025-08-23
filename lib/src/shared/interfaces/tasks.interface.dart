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

  factory TasksInterface.fromMap(Map<String, dynamic> map) {
    return TasksInterface(
      title: map['title_task'],
      description: map['description'],
      priority: map['value_priority'],
      completed: map['complete'],
      id: map['id'],
    );
  }
}
