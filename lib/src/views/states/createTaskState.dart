class CreateTasksState {
  CreateTasksState({this.title_task = "", this.description = ""});
  String title_task;
  String description;

  void setTitle(String title) {
    this.title_task = title;
  }

  void setDescription(String description) {
    this.description = description;
  }
}
