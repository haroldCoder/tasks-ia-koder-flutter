import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/domain/models/task_server_model.dart';
import 'package:tasks_ia_koderx/src/presentation/completed_tasks/infrastructure/uploadedTasks.dart';

final uploadedTasksProvider =
    AsyncNotifierProvider<UploadedTasks, List<ITaskServerModel>>(UploadedTasks.new);
