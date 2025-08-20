import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ButtonGoogle.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premiumUser.dart';

void showUserNotLogged(BuildContext context, AuthService authService) {
  showShadDialog(
      context: context,
      builder: (ctx) {
        ever(authService.logged, (logged) async {
          if (logged == true) {
            if (Navigator.of(ctx).canPop()) {
              Navigator.of(ctx).pop();
            }
          }
        });
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ShadDialog.alert(
              radius: BorderRadius.all(Radius.circular(10)),
              removeBorderRadiusWhenTiny: false,
              title: Text("Usuario no esta loggeado"),
              actions: [Buttongoogle()]),
        );
      });
  PremiumUser().ResetPremiumUser();
}
