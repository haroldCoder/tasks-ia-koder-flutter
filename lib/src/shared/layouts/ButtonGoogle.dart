import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/loginUser.dart';

import '../../widgets/Button/Button.dart';
import '../utils/premiumUser.dart';

class Buttongoogle extends StatefulWidget {
  const Buttongoogle({super.key});

  @override
  State<Buttongoogle> createState() => _ButtongoogleState();
}

class _ButtongoogleState extends State<Buttongoogle> {
  AuthService authService = Get.put(AuthService());
  LoginUser loginUser = LoginUser();
  PremiumUser isUserPremium = Get.put(PremiumUser());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = authService.current_user.value;
      return Button(
          click: () async {
            if (!authService.logged.value) {
              await authService.SignInWithGoogle();
              await loginUser.login(
                  user?.email, user?.phoneNumber, user?.displayName ?? "");
              if (user != null) {
                isUserPremium.verifyUser(user.email.toString());
              }
            } else {
              await authService.logoutGoogle();
              isUserPremium.ResetPremiumUser();
            }
          },
          width: MediaQuery.of(context).size.width * 0.9,
          style: ButtonStyle(
              shape: MaterialStatePropertyAll<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white10)),
          contentbtn: Obx(() {
            return !authService.logged.value
                ? Image.asset(
                    'lib/assets/googleicon.png',
                    width: 30,
                  )
                : Text(
                    logOut,
                    style: TextStyle(color: Colors.blueAccent),
                  );
          }));
    });
  }
}
