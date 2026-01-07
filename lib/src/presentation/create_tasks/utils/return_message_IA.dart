import 'package:tasks_ia_koderx/src/domain/models/messages_IA_model.dart';
import 'package:tasks_ia_koderx/src/presentation/create_tasks/widgets/button_AI/enum/typeRef.dart';
import 'package:tasks_ia_koderx/src/shared/lang/createTask/lang.dart';

List<IMessagesIAModel> returnMessageIA(Typeref typeref, String promp) {
  List<IMessagesIAModel> messages = [
    IMessagesIAModel(role: 'system', content: systemInteractue),
    IMessagesIAModel(
        role: 'user',
        content: typeref == Typeref.title
            ? '$titlePromp$promp'
            : '$descriptionPromp$promp')
  ];

  return messages;
}
