import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class ConfigureAgentsIa {
  StreamController<Response> _streamController = StreamController<Response>();

  final ModelIA model;
  final List<MessagesIAInterface> messages;

  ConfigureAgentsIa({required this.model, required this.messages});

  Stream<Response> get stream => _streamController.stream;

  makeBrain() async {
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
            'model': this.model.path,
            'messages': this.messages.map((m) => m.toJson()).toList(),
          });

      print(response.statusCode);
      _streamController.add(response);
    } catch (err) {
      _streamController.addError('Err: $err');
    }
  }
}
