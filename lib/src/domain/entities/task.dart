
abstract class Task {
  final String id;
  final String title;
  final String description;
  final int priority;
  final int completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.completed,
  });
}
