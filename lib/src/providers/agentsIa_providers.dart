import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/domain/models/agent_state_model.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/domain/entities/brain_state.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/state/brain_notifier.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/configure_agents_IA.dart';

final agentNotifierProvider =
StateNotifierProvider<AgentNotifier, IAgentStateModel>((ref) {
  final notifier = AgentNotifier();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

final brainProvider = NotifierProvider<BrainNotifier, BrainState>(BrainNotifier.new);