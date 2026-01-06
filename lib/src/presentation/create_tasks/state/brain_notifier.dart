import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/entities/brain_state.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAI.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
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
    state = state.copyWith(
        loading: value, clearError: value, hasError: false, textGenerated: "");
  }

  void setError(Object error) {
    state = state.copyWith(
        error: error, loading: false, hasError: true, textGenerated: "");
  }

  void setTextGenerated(String text) {
    state = state.copyWith(textGenerated: text);
  }

  Future<void> generateBrain(String prompt) async {
    try {
      state = state.copyWith(
          loading: true, clearError: true, hasError: false, textGenerated: "");

      final configureAI = ConfigureAI();
      final content = [Content.text(prompt)];
      final response = await configureAI.model.generateContent(content);

      if (response.text != null) {
        state = state.copyWith(loading: false, textGenerated: response.text!);
      } else {
        throw Exception("Generated text is null");
      }
    } catch (e) {
      state = state.copyWith(loading: false, error: e, hasError: true);
    }
  }
}
