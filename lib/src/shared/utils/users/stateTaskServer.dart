import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getEmailUserApp.dart';
import 'package:tasks_ia_koderx/src/shared/utils/users/getIdUser.dart';

class StateTaskServerNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() async{
    return false;
  }

  Future<int> getIdUser() async {
    final response = await GetIdUser().buildRequest(await getEmailUser());
    return response;
  }

  Future<void> searchTask(String idTaks) async {
    state = const AsyncLoading();

    try {
      var response = await Requests(baseUrl: dotenv.env["API_URL"].toString())
          .request(
              method: HttpMethod.get,
              endpoint: "v1/tasks/task/search/$idTaks/${await getIdUser()}");


      if (response["httpStatus"] == 200) {
        state = const AsyncData(true);
      } else {
        state = const AsyncData(false);
      }
    } catch (err, stack) {
      state = AsyncError(err, stack);
    }
  }
}
