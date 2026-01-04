import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:tasks_ia_koderx/src/shared/lang/AI/lang.dart';

Future<String> generateBrain(
    GenerativeModel model, String value, WidgetRef ref) async {
  final notifier = ref.read(brainProvider.notifier);

  try {
    notifier.setLoading(true);

    final response =
        await model.startChat().sendMessage(Content.text('${generateText} ${value}'));
    notifier.setLoading(false);

    return response.text ?? "";
  } catch (err) {
    print(err);
    notifier.setError(err);
  }

  return "";
}
