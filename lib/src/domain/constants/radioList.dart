import 'package:tasks_ia_koderx/src/domain/models/radio_model.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';

List<IRadioModel> get priorityOptions => [
  IRadioModel(title: hightPriority, value: 1),
  IRadioModel(title: mediumPriority, value: 2),
  IRadioModel(title: lowPriority, value: 3),
];