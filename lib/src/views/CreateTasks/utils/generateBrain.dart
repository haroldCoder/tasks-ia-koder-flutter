import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/shared/lang/AI/lang.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/enum/elementId.dart';

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

class BrainNotifier extends Notifier<BrainState> {
  @override
  BrainState build() {
    return const BrainState();
  }

  void selectElement(ElementId element) {
    state = state.copyWith(elementId: element);
  }

  void setLoading(bool value) {
    state = state.copyWith(loading: value, clearError: value, hasError: false);
  }

  void setError(Object error) {
    state = state.copyWith(error: error, loading: false, hasError: true);
  }
}

final _container = ProviderContainer();

Future<void> generateBrain(
    GenerativeModel model, String value, void Function(String) function) async {
  final notifier = _container.read(brainProvider.notifier);

  try {
    notifier.setLoading(true);

    final response =
        await model.startChat().sendMessage(Content.text('${generateText} ${value}'));
    function(response.text.toString());
    notifier.setLoading(false);
  } catch (err) {
    print(err);
    notifier.setError(err);
  }
}
