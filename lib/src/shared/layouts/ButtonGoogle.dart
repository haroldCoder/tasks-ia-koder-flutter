import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/auth_service.dart';
import 'package:tasks_ia_koderx/src/shared/utils/login_user.dart';
import 'package:tasks_ia_koderx/src/shared/utils/premium_user.dart';

import '../../widgets/Button/Button.dart';

class Buttongoogle extends ConsumerWidget {
  const Buttongoogle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);
    final authService = ref.read(authServiceProvider.notifier);
    final loginUser = LoginUser();

    return Button(
        click: () async {
          if (!authState.logged) {
            await authService.signInWithGoogle();
            final user = ref.read(authServiceProvider).currentUser;
            if (user != null) {
              await loginUser.login(
                  user.email, user.phoneNumber, user.displayName ?? "");
              ref.read(premiumUserProvider.notifier).verifyUser(user.email.toString());
            }
          } else {
            await authService.logoutGoogle();
            ref.read(premiumUserProvider.notifier).resetPremiumUser();
          }
        },
        width: MediaQuery.of(context).size.width * 0.9,
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.white10)),
        contentbtn: !authState.logged
            ? Image.asset(
                'lib/assets/googleicon.png',
                width: 30,
              )
            : Text(
                logOut,
                style: TextStyle(color: Colors.blueAccent),
              ));
  }
}
