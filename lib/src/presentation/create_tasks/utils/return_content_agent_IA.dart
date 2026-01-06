import 'dart:convert';

import 'package:http/http.dart';

String returnContentAgentIA(Response data) {
  final dataConvert = jsonDecode(data.body);
  String content = dataConvert["choices"][0]["message"]["content"];

  if (content.contains('Ã')) {
    content = utf8.decode(latin1.encode(content), allowMalformed: true);
  }

  content = content.replaceAll("\n", " ")
      .replaceAll("\r", " ")
      .replaceAll(RegExp(r'[^\w\sáéíóúÁÉÍÓÚñÑ.,:;!?()-]'), "")
      .trim();
    
  return content;
}
