import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getIdUser.dart';

class StateTaskServer {
  StreamController<bool> _stateTaskController = StreamController<bool>();
  Stream<bool> get stream => _stateTaskController.stream;

  Future<int> getIdUser() async {
    final response = await GetIdUser().buildRequest(await getEmailUser());
    return response;
  }

  searchTask(int idtaks) async {
    try {
      var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
          .request(
              method: HttpMethod.get,
              endpoint: "v1/tasks/task/search/${idtaks}/${await getIdUser()}");


      if (response["httpStatus"] == 200) {
        _stateTaskController.add(true);
      } else {
        _stateTaskController.add(false);
      }
    } catch (err) {
      _stateTaskController.addError(err);
    }
  }

  void dispose() {
    _stateTaskController.close();
  }
}
