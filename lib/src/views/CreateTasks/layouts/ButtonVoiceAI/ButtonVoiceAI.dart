import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';
import 'package:tasks_ia_koderx/src/views/CreateTasks/layouts/ButtonVoiceAI/layouts/VoiceAiView.dart';
import 'package:tasks_ia_koderx/src/widgets/Overlay/OverlayFixed.dart';
import 'package:tasks_ia_koderx/src/widgets/PopUp/PopUp.dart';

class ButtonvoiceAi extends ConsumerWidget {
  ButtonvoiceAi({super.key, this.enabled});
  final bool? enabled;

  void openDialogVoice(BuildContext context) {
    showShadDialog(
      context: context,
      builder: (context) => Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: PopUp(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            title: Text(
              "Voice IA",
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
            bg: Color(0xB0000000),
            actions: [],
            child: VoiceAiview(),
          )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Overlayfixed(
        bottom: 40,
        right: 25,
        widget: Consumer(builder: (contex, ref, _) {
          final isConnected = ref.watch(isConnectedProvider);
          bool isEnabled = (enabled == true) || isConnected;

          return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: (isConnected)
                        ? Color(0xFF01FF6B).withOpacity(0.6)
                        : Colors.grey,
                    blurRadius: 16,
                    spreadRadius: .5,
                    offset: Offset(0, 2),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed:
                    (isConnected) ? () => openDialogVoice(context) : null,
                icon: Icon(
                  Icons.mic,
                  color: isEnabled ? Color(0xFF00F7A5) : Colors.grey,
                  size: 35,
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF161616)),
                ),
              ));
        }));
  }
}
