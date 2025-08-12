import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/views/states/createTaskState.dart';

void updateDataTask(
    Rx<CreateTasksState> task, String value, ElementId element) {
  switch (element) {
    case ElementId.title_input:
      task.update((t) {
        if (t != null) t.setTitle(value);
      });
      break;
    case ElementId.desc_textBox:
      task.update((t) {
        if (t != null) t.setDescription(value);
      });
      break;
    default:
      break;
  }
}
