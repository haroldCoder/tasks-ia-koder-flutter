import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ErrorAgent/ErrorAgentIA.dart';

void showErrorAgentIA({
  required BuildContext context,
  required String description,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showShadDialog(
      context: context,
      builder: (context) {
        return ErroragentIA(description: description);
      },
    );
  });
}
