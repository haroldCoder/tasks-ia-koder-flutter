import 'dart:convert';

import 'package:http/http.dart';

String returnContentAgentIA(Response snapshot) {
  final data = jsonDecode(snapshot.body);
  String content = jsonEncode(data["choices"][0]["message"]["content"]);
  content = utf8.decode(latin1.encode(content), allowMalformed: true);

  return content;
}
