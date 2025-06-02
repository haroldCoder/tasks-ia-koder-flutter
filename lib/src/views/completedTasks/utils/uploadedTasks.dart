import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasksServer.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class UploadedTasks {
  final StreamController<List<TasksServer>> tasksController = StreamController<List<TasksServer>>();

  getUploadedTasks(String email) async {
    try {
      final response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
          .request(method: HttpMethod.get, endpoint: "v1/tasks/tasks/${email}");

      final taskList = response['response'] as List<dynamic>;
      final tasks = taskList.map((json) => TasksServer.fromJson(json) as TasksServer).toList();

      tasksController.add(tasks);
    } catch (err) {
      tasksController.add([]);
    }
  }
}
