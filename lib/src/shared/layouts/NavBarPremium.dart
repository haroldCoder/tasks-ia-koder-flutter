import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/Button/Button.dart';

class Navbarpremium extends StatelessWidget {
  const Navbarpremium({super.key});

  backPage(BuildContext context) {
    if (!context.mounted) return;
    Future.microtask(() => context.pop());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Button(
          style: const ButtonStyle(
              alignment: Alignment.centerLeft,
              padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.all(0)),
              backgroundColor: MaterialStatePropertyAll<Color>(
                  Colors.transparent)),
          click: () => backPage(context),
          contentbtn: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.star,
          size: 20,
          color: Colors.amber,
        )
      ],
    );
  }
}
