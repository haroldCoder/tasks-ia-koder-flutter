import 'dart:convert';

import 'package:http/http.dart';

String returnContentAgentIA(Response snapshot) {
  final data = jsonDecode(snapshot.body);
  String content = data["choices"][0]["message"]["content"];
  content = utf8.decode(latin1.encode(content), allowMalformed: true).replaceAll("\n", " ")
    .replaceAll("\r", " ")
    .replaceAll(RegExp(r'[^\w\sáéíóúÁÉÍÓÚñÑ.,:;!?()-]'), "")
    .substring(1);
    
  return content;
}
