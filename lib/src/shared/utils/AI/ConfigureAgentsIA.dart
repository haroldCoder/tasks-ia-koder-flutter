import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';
import 'package:tasks_ia_koderx/src/shared/enums/http_method.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/Requests.dart';

class AgentState {
  final ElementId select;
  final bool loading;
  final http.Response? response;
  final String? error;
  final bool hasError;


  const AgentState({
    this.select = ElementId.worthless,
    this.loading = false,
    this.response,
    this.error,
    this.hasError = false,
  });

  AgentState copyWith({
    ElementId? select,
    bool? loading,
    http.Response? response,
    String? error,
    bool? hasError,
    bool setResponseToNull = false,
    bool setErrorToNull = false,
  }) {
    return AgentState(
      select: select ?? this.select,
      loading: loading ?? this.loading,
      response: setResponseToNull ? null : (response ?? this.response),
      error: setErrorToNull ? null : (error ?? this.error),
      hasError: hasError ?? this.error != null,
    );
  }
}

class AgentNotifier extends StateNotifier<AgentState> {
  AgentNotifier() : super(const AgentState());

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
      );

      localResponse =
          await Requests(baseUrl: 'https://openrouter.ai/').makeRequest(
              method: HttpMethod.post,
              endpoint: 'api/v1/chat/completions',
              headers: {
                'Authorization':
                    'Bearer \${dotenv.env["OPEN_API_KEY"].toString()}',
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
      print(err);
      state = state.copyWith(
        loading: false,
        error: 'Err: \$err',
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
