
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tasks_ia_koderx/src/shared/utils/AuthService.dart';
import 'package:tasks_ia_koderx/src/shared/utils/loginUser.dart';

import '../../widgets/Button/Button.dart';

class Buttongoogle extends StatefulWidget {
  const Buttongoogle({super.key});

  @override
  State<Buttongoogle> createState() => _ButtongoogleState();
}

class _ButtongoogleState extends State<Buttongoogle> {
  AuthService authService = AuthService();
  LoginUser loginUser = LoginUser();

  @override
  Widget build(BuildContext context) {
    return Button(
        click: () async {
          if (!authService.logged.value) {
            await authService.SignInWithGoogle();
            await loginUser.login(
                authService.current_user.value?.email,
                authService.current_user.value?.phoneNumber,
                authService
                    .current_user.value?.displayName ??
                    "");
          } else {
            await authService.logoutGoogle();
          }
        },
        width: MediaQuery.of(context).size.width * 0.9,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12))),
            backgroundColor:
            MaterialStatePropertyAll<Color>(
                Colors.white10)),
        contentbtn: Obx(() {
          return !authService.logged.value
              ? Image.asset(
            'lib/assets/googleicon.png',
            width: 30,
          )
              : Text(
            "Cerrar sesion",
            style:
            TextStyle(color: Colors.blueAccent),
          );
        }));
  }
}
