import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/domain/constants/modelsIASelect.dart';
import 'package:tasks_ia_koderx/src/providers/configApp_provider.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/Select/Select.dart';

class SelectModelAI extends ConsumerWidget {
  SelectModelAI({super.key, this.enabled = true});

  final bool enabled;

  void onChangeModelIA(ConfigAppNotifier configAppController, String value) {
    configAppController
        .changeModelIA(ModelIA.values.firstWhere((md) => md.path == value));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configAppController = ref.read(configAppProvider.notifier);
    final configAppState = ref.watch(configAppProvider);

    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
      children: [
        Text(tr(modelText), style: TextStyle(color: const Color(0xFF666666), fontSize: 15)),
        Select(
            enabled: enabled,
            trailing: Icon(Icons.keyboard_arrow_down, color: Colors.blue),
            colorletter: Colors.white,
            decoration: ShadDecoration(
                color: const Color(0xFF000000),
                border: ShadBorder(
                    top: ShadBorderSide(
                        color: const Color(0xFF00569C), width: 2),
                    bottom: ShadBorderSide(color: Color(0xFF00569C), width: 2),
                    left: ShadBorderSide(color: Color(0xFF00569C), width: 2),
                    right: ShadBorderSide(color: Color(0xFF00569C), width: 2))),
            options: modelsAIOptions
                .map((k, v) => MapEntry(k.path.toString(), v.path.toString())),
            onchange: (String value) => onChangeModelIA(configAppController, value),
            initialValue: configAppState.modelAi.toString())
      ],
    ));
  }
}
