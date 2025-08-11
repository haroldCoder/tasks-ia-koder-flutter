import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';

class ListenAgentsIAChanges extends GetxController{
  Rx<ElementId> select = ElementId.worthless.obs;
  Rx<bool> loading = false.obs;

  void assignElementSelect(ElementId element){
    select.value = element;
  }

  void changeLoading(bool value){
    loading.value = value;
  }

}

class ConfigureAgentsIa extends GetxController{
  final StreamController<http.Response> _streamController = StreamController<http.Response>.broadcast();
  final _listenAgentsIAChanges = Get.put(ListenAgentsIAChanges());
  

  Stream<http.Response> get stream => _streamController.stream;

  Future<void> makeBrain(ModelIA model, List<MessagesIAInterface> messages, [ElementId? element]) async {
    try {
      if(element != null){
        _listenAgentsIAChanges.assignElementSelect(element);
      }

      _listenAgentsIAChanges.changeLoading(true);
      http.Response response = await Requests(baseUrl: 'https://openrouter.ai/')
          .makeRequest(
              method: HttpMethod.post,
              endpoint: 'api/v1/chat/completions',
              headers: {
            'Authorization': 'Bearer ${dotenv.env["OPEN_API_KEY"].toString()}',
            'Content-Type': 'application/json'
          },
              body: {
            'model': model.path,
            'messages': messages.map((m) => m.toJson()).toList(),
          });
          
      _streamController.add(response);
      _listenAgentsIAChanges.changeLoading(false);
      if(kDebugMode){
        print(response.body);
      }
    } catch (err) {
      print(err);
      _streamController.addError('Err: $err');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _streamController.close();
  }
}
