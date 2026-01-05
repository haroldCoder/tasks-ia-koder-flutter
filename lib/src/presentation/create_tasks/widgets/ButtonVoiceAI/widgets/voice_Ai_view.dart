import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/lang/voiceAI/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/SelectModelIA.dart';
import 'package:tasks_ia_koderx/src/widgets/voice_recorder/voice_recorder.dart';

class VoiceAiView extends StatelessWidget {
  const VoiceAiView({super.key});

  void pressed() {}

  void msgOnTap(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
            image: AssetImage('lib/assets/iavoice.png'),
            width: 100,
            height: 100),
        SizedBox(
          height: 50,
        ),
        SelectModelAI(),
        SizedBox(
          height: 50,
        ),
        Column(
          spacing: 5,
          children: [
            VoiceRecorder(
              widget: Icon(
                Icons.mic,
                color: Color(0xFF00F74A),
                size: 35,
              ),
              onPressed: (Function fn) {
                fn();
              },
            ),
            Text(
              pressedOn,
              style: TextStyle(color: const Color(0xFF494949)),
            )
          ],
        )
      ],
    );
  }
}
