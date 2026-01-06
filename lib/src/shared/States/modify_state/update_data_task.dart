import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/element_id.dart';
import 'package:tasks_ia_koderx/src/shared/class/tasks/TaskDataManage.dart';

void updateDataTask(
    WidgetRef ref, String value, ElementId element) {
  final taskNotifier = ref.read(taskDataManageProvider.notifier);

  switch (element) {
    case ElementId.title_input:
      taskNotifier.setTitle(value);
      break;
    case ElementId.desc_textBox:
      taskNotifier.setDescription(value);
      break;
    default:
      break;
  }
}
