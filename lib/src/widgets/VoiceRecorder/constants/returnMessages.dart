import 'package:tasks_ia_koderx/src/shared/enums/langs.dart';
import 'package:tasks_ia_koderx/src/shared/lang/voiceAI/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/enum/messageTypes.dart';

String returnMessage(String msg, MessageTypes type, {Languages lang = Languages.es}){
  switch(type){
    case MessageTypes.title:
      if(lang == Languages.es){
        return '$generateTitle $msg$titleObs';
      }
      break;
      
    case MessageTypes.descripcion:
      if(lang == Languages.es){
        return '$generateDescription $msg$descriptionObs';
      }
      break;
  }
  return "";
}