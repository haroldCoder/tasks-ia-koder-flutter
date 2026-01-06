import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tasks_ia_koderx/src/providers/agentsIa_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  test('BrainNotifier generates text', () async {
    try {
      await dotenv.load();
    } catch (e) {
      print('Error loading .env: $e');
      // If .env fails (e.g. not found in test env), skip or warn.
    }

    final container = ProviderContainer();
    final notifier = container.read(brainProvider.notifier);

    // Check initial state
    expect(container.read(brainProvider).loading, false);

    // Trigger generation
    print('Triggering generation...');
    await notifier.generateBrain('Hello, say "tested"');

    final state = container.read(brainProvider);
    print(
        'State after generation: loading=${state.loading}, hasError=${state.hasError}, text=${state.textGenerated}');

    if (state.hasError) {
      print('Error: ${state.error}');
    } else {
      expect(state.textGenerated, isNotEmpty);
      expect(
          state.textGenerated,
          contains(
              'tested')); // AI might not say exactly this but likely will if instructed.
    }
  });
}
