import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<String> getEmailUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final data_user = prefs.getString("data_user");

  final Map<String, dynamic> userJson = jsonDecode(data_user!);

  return userJson["email"].toString();
}