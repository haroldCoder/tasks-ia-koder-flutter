import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';

part 'brain_state.freezed.dart';

@freezed
class BrainState with _$BrainState {
  const factory BrainState({
    @Default(ElementId.worthless) ElementId elementId,
    @Default(false) bool loading,
    Object? error,
    @Default(false) bool hasError,
    @Default("") String textGenerated,
    @Default(false) bool clearError,
  }) = _BrainState;

  const BrainState._();

  BrainState customCopyWith({
    ElementId? elementId,
    bool? loading,
    Object? error,
    bool? clearError,
    bool? hasError,
    String? textGenerated,
  }) {
    return copyWith(
      elementId: elementId ?? this.elementId,
      loading: loading ?? this.loading,
      error: clearError ?? false ? null : error ?? this.error,
      hasError: (error != null) ? true : (hasError ?? this.hasError),
      textGenerated: textGenerated ?? this.textGenerated,
    );
  }
}
