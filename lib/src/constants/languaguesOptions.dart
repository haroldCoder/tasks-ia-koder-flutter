import 'package:tasks_ia_koderx/src/constants/class/ValuesMenu.dart';
import 'package:tasks_ia_koderx/src/shared/enums/langs.dart';

class ValuesLanguagues extends ValuesMenu<Languages, String>{
  ValuesLanguagues(String value, Languages ln) : super(value, ln);
}

List<ValuesLanguagues> languaguesOptions = [
  ValuesLanguagues('Español', Languages.es),
  ValuesLanguagues('English', Languages.en)
];