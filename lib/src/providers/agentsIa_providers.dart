import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/domain/entities/brain_state.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AI/ConfigureAgentsIA.dart';
import 'package:tasks_ia_koderx/src/presentation/CreateTasks/state/brain_notifier.dart';

final agentNotifierProvider =
StateNotifierProvider<AgentNotifier, AgentState>((ref) {
  final notifier = AgentNotifier();
  ref.onDispose(() => notifier.dispose());
  return notifier;
});

final brainProvider = NotifierProvider<BrainNotifier, BrainState>(BrainNotifier.new);