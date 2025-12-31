import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/enum/elementId.dart';

class BrainState {
  final ElementId elementId;
  final bool loading;
  final Object? error;
  final bool hasError;

  const BrainState({
    this.elementId = ElementId.worthless,
    this.loading = false,
    this.error,
    this.hasError = false,
  });

  BrainState copyWith({
    ElementId? elementId,
    bool? loading,
    Object? error,
    bool clearError = false,
    bool? hasError,
  }) {
    return BrainState(
      elementId: elementId ?? this.elementId,
      loading: loading ?? this.loading,
      error: clearError ? null : error ?? this.error,
      hasError: error != null,
    );
  }
}