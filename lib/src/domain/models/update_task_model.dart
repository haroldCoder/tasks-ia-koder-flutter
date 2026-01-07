class IUpdateModel {
  String? title;
  String? description;
  int? priority;
  int? completed;
  int? id;

  IUpdateModel(
      {this.title,
      this.description,
      this.priority,
      this.completed,
      this.id});

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    if (title != null) data['title_task'] = title;
    if (description != null) data['description'] = description;
    if (priority != null) data['value_priority'] = priority;
    if (completed != null) data['complete'] = completed;
    if (id != null) data['id'] = id;
    return data;
  }
}