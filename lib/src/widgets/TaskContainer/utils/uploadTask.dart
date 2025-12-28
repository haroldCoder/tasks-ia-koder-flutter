import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_ia_koderx/src/shared/interfaces/tasks.interface.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premiumUser.dart';
import '../../../shared/layouts/ButtonPremium.dart';

class UploadTask {
  void Upload(BuildContext context, TasksInterface task, WidgetRef ref) async {
    final premiumUserController = ref.read(premiumUserProvider.notifier);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final data_user = prefs.getString("data_user");

    final Map<String, dynamic> userJson = jsonDecode(data_user!);
    if (!await premiumUserController.verifyUser(userJson['email'].toString())) {
      showShadDialog(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ShadDialog.alert(
                  radius: BorderRadius.all(Radius.circular(10)),
                  removeBorderRadiusWhenTiny: false,
                  title: Text("Usuario no es premium"),
                  actions: [Buttonpremium()]),
            );
          });
    } else {
      context.push("/upload-task", extra: task);
    }
  }
}
