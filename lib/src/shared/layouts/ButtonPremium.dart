import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/shared/lang/settings/lang.dart';
import 'package:tasks_ia_koderx/src/shared/utils/auth_service.dart';

import '../../widgets/Button/Button.dart';
import '../utils/subscription_request.dart';

class Buttonpremium extends ConsumerWidget {
  const Buttonpremium({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authServiceProvider);

    return Button(
      contentbtn: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.white12],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(changePremium,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      style: ButtonStyle(
        alignment: Alignment.topLeft,
        padding:
            MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(0)),
        shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      click: () {
        SubscriptionRequests()
            .createSubscription(authState.currentUser?.email);
      },
    );
  }
}
