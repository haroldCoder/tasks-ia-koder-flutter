import 'package:tasks_ia_koderx/src/constants/class/radiointerface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';

List<RadioInterface> get priorityOptions => [
  RadioInterface(title: hightPriority, value: 1),
  RadioInterface(title: mediumPriority, value: 2),
  RadioInterface(title: lowPriority, value: 3),
];