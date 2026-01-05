import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/entities/brain_state.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/enum/elementId.dart';

class BrainNotifier extends Notifier<BrainState> {
  @override
  BrainState build() {
    return const BrainState();
  }

  void selectElement(ElementId element) {
    state = state.copyWith(elementId: element, textGenerated: "");
  }

  void setLoading(bool value) {
    state = state.copyWith(loading: value, clearError: value, hasError: false, textGenerated: "");
  }

  void setError(Object error) {
    state = state.copyWith(error: error, loading: false, hasError: true, textGenerated: "");
  }

  void setTextGenerated(String text) {
    state = state.copyWith(textGenerated: text);
  }
}
