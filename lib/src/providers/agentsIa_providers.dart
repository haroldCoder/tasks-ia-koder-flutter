import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/utils/generateBrain.dart';

final agentNotifierProvider =
StateNotifierProvider<AgentNotifier, AgentState>((ref) {
  final notifier = AgentNotifier();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

final brainProvider = NotifierProvider<BrainNotifier, BrainState>(BrainNotifier.new);