import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class StateTaskServer {
  StreamController<bool> _stateTaskController = StreamController<bool>();
  Stream<bool> get stream => _stateTaskController.stream;

  searchTask(int idtaks) async {
    var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
        .request(
            method: HttpMethod.get, endpoint: "v1/tasks/task/search/${idtaks}");


    if (response["httpStatus"] == 200) {
      _stateTaskController.add(true);
    }
    else{
      _stateTaskController.add(false);
    }
  }

  void dispose() {
    _stateTaskController.close();
  }
}
