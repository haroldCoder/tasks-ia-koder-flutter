import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class ConfigureAgentsIa {
  StreamController<Response> _streamController = StreamController<Response>.broadcast();

  Stream<Response> get stream => _streamController.stream;

  makeBrain(ModelIA model, List<MessagesIAInterface> messages) async {
    try {
      Response response = await Requests(baseUrl: 'https://openrouter.ai/')
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

      print(response.statusCode);
      _streamController.add(response);
    } catch (err) {
      print(err);
      _streamController.addError('Err: $err');
    }
  }
}
