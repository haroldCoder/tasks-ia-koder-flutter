import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/constants/modelsIASelect.dart';
import 'package:tasks_ia_koderx/src/shared/States/configApp.dart';
import 'package:tasks_ia_koderx/src/shared/enums/modelIa.dart';
import 'package:tasks_ia_koderx/src/widgets/Select/Select.dart';

class SelectModelAI extends StatelessWidget {
  SelectModelAI({super.key});
  final configApp = Get.find<ConfigAppState>();

  void onChangeModelIA(String value) {
    configApp
        .changeModelIA(ModelIA.values.firstWhere((md) => md.path == value));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 10,
      children: [
        Text("Modelo de IA: ", style: TextStyle(color: const Color(0xFF666666), fontSize: 15)),
        Obx((){
          return Select(
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
            onchange: (String value) => onChangeModelIA(value),
            initialValue: configApp.model_ai.value.toString());
        })
      ],
    ));
  }
}
