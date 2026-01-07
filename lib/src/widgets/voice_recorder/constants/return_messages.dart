import 'package:tasks_ia_koderx/src/shared/lang/voiceAI/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/voice_recorder/enum/messageTypes.dart';

String returnMessage(String msg, MessageTypes type) {
  switch (type) {
    case MessageTypes.title:
      return '$generateTitle $msg$titleObs';

    case MessageTypes.descripcion:
      return '$generateDescription $msg$descriptionObs';
  }
}
