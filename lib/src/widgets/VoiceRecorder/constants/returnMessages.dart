import 'package:tasks_ia_koderx/src/shared/enums/langs.dart';
import 'package:tasks_ia_koderx/src/widgets/VoiceRecorder/enum/messageTypes.dart';

String returnMessage(String msg, MessageTypes type, {Languages lang = Languages.es}){
  switch(type){
    case MessageTypes.title:
      if(lang == Languages.es){
        return 'Genera un titulo breve y descriptivo basado en una idea de tarea proporcionada: $msg. Devuélvelo sin explicaciones, solo el título.';
      }
      break;
      
    case MessageTypes.descripcion:
      if(lang == Languages.es){
        return 'Genera una descripcion breve de lo que podria llevar esta tarea: $msg. no me des introduccion';
      }
      break;
  }
  return "";
}