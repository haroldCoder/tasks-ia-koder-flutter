import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_ia_koderx/src/domain/models/agent_state_model.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class AgentNotifier extends StateNotifier<IAgentStateModel> {
  AgentNotifier() : super(const IAgentStateModel());

  Future<void> makeBrain(ModelIA model, List<MessagesIAInterface> messages,
      [ElementId? element]) async {
    http.Response? localResponse;
    try {
      state = state.copyWith(
        loading: true,
        select: element,
        setResponseToNull: true,
        setErrorToNull: true,
        hasError: false,
        response: null
      );

      localResponse =
          await Requests(baseUrl: 'https://openrouter.ai/').makeRequest(
              method: HttpMethod.post,
              endpoint: 'api/v1/chat/completions',
              headers: {
                'Authorization':
                    'Bearer ${dotenv.env["OPENROUTER_API_KEY"].toString()}',
                'Content-Type': 'application/json'
              },
              body: {
                'model': model.path,
                'messages': messages.map((m) => m.toJson()).toList(),
              });

      if (localResponse.statusCode == 200) {
        state = state.copyWith(
          loading: false,
          response: localResponse,
          setErrorToNull: true,
          hasError: false,
        );
      } else {
        state = state.copyWith(
          loading: false,
          error: 'Error: \${localResponse.statusCode} \${localResponse.body}',
          setResponseToNull: true,
          hasError: true,
        );
      }
    } catch (err) {
      state = state.copyWith(
        loading: false,
        error: 'Err: $err',
        setResponseToNull: true,
        hasError: true,
      );
    } finally {
      if (kDebugMode && localResponse != null) {
        print(localResponse.body);
      }
    }
  }
}
