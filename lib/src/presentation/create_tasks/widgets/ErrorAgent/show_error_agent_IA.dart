import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ErrorAgent/error_agent_IA.dart';

void showErrorAgentIA({
  required BuildContext context,
  required String description,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showShadDialog(
      context: context,
      builder: (context) {
        return ErrorAgentIA(description: description);
      },
    );
  });
}
