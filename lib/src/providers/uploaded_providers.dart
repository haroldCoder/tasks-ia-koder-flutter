import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/completedTasks/infrastructure/uploadedTasks.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';

final uploadedTasksProvider =
    AsyncNotifierProvider<UploadedTasks, List<TasksServer>>(UploadedTasks.new);
