import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';

class ConfigAppState {
  final Color colorTheme;
  final ModelIA modelAi;

  const ConfigAppState({
    this.colorTheme = Colors.black,
    this.modelAi = ModelIA.gemma3nE4Bit,
  });

  ConfigAppState copyWith({
    Color? colorTheme,
    ModelIA? modelAi,
  }) {
    return ConfigAppState(
      colorTheme: colorTheme ?? this.colorTheme,
      modelAi: modelAi ?? this.modelAi,
    );
  }
}

class ConfigAppNotifier extends Notifier<ConfigAppState> {
  @override
  ConfigAppState build() {
    return const ConfigAppState();
  }

  void changeColorThemeApp(Color color) {
    state = state.copyWith(colorTheme: color);
  }

  void changeModelIA(ModelIA modelIa) {
    state = state.copyWith(modelAi: modelIa);
  }
}

final configAppProvider = NotifierProvider<ConfigAppNotifier, ConfigAppState>(ConfigAppNotifier.new);
