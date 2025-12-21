import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/views/completedTasks/utils/uploadedTasks.dart';

final uploadedTasksProvider =
    AsyncNotifierProvider<UploadedTasks, List<TasksServer>>(UploadedTasks.new);
