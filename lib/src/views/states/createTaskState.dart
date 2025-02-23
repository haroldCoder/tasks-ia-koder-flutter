class CreateTasksState {
  CreateTasksState(
      {this.title_task = "",
      this.description = "",
      this.value_priority = 1,
      this.id,
      this.complete = 0});
  final int? id;
  String title_task;
  String description;
  int value_priority;
  int complete;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title_task': title_task,
      'description': description,
      'value_priority': value_priority,
      'complete': complete
    };
  }

  factory CreateTasksState.fromMap(Map<String, dynamic> map) {
    return CreateTasksState(
      id: map['id'],
      title_task: map['title_task'],
      description: map['description'],
      value_priority: map['value_priority'],
      complete: map["complete"],
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title_task, description: $description, priority: $value_priority, complete: $complete';
  }

  void setTitle(String title) {
    this.title_task = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setPriorityValue(int priority_value) {
    this.value_priority = priority_value;
  }

  void resetData() {
    this.description = "";
    this.value_priority = 1;
    this.title_task = "";
  }
}
