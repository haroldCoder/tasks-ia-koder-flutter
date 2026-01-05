import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';
import 'package:http/http.dart' as http;

class IAgentStateModel {
  final ElementId select;
  final bool loading;
  final http.Response? response;
  final String? error;
  final bool hasError;


  const IAgentStateModel({
    this.select = ElementId.worthless,
    this.loading = false,
    this.response,
    this.error,
    this.hasError = false,
  });

  IAgentStateModel copyWith({
    ElementId? select,
    bool? loading,
    http.Response? response,
    String? error,
    bool? hasError,
    bool setResponseToNull = false,
    bool setErrorToNull = false,
  }) {
    return IAgentStateModel(
      select: select ?? this.select,
      loading: loading ?? this.loading,
      response: setResponseToNull ? null : (response ?? this.response),
      error: setErrorToNull ? null : (error ?? this.error),
      hasError: hasError ?? this.error != null,
    );
  }
}