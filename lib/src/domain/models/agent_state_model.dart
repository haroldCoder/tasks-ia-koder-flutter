import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';
import 'package:http/http.dart' as http;

part 'agent_state_model.freezed.dart';

@freezed
class IAgentStateModel with _$IAgentStateModel {
  const factory IAgentStateModel({
    @Default(ElementId.worthless) ElementId select,
    @Default(false) bool loading,
    http.Response? response,
    String? error,
    @Default(false) bool hasError,
  }) = _IAgentStateModel;
}