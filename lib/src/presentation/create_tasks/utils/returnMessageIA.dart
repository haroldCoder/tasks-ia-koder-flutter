import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/ButtonAI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/messagesIA.interface.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';

List<MessagesIAInterface> returnMessageIA(Typeref typeref, String promp) {
  List<MessagesIAInterface> messages = [
    MessagesIAInterface(role: 'system', content: systemInteractue),
    MessagesIAInterface(
        role: 'user',
        content: typeref == Typeref.title
            ? '$titlePromp$promp'
            : '$descriptionPromp$promp')
  ];

  return messages;
}
