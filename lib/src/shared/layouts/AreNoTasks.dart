import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:tasks_ia_koderx/src/shared/lang/home/lang.dart';
import 'package:tasks_ia_koderx/src/widgets/Animations/Animations.dart';

class AreNoTasks extends StatelessWidget {
  const AreNoTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
      children: [
        Animations(
          duration: Duration(seconds: 1),
          child:
              SvgPicture.asset('lib/assets/check.svg', width: 50, height: 50),
          transitionBuilder: (Widget? child, AnimationController controller) {
            return ScaleTransition(
              scale: TweenSequence<double>([
                TweenSequenceItem(
                    tween: Tween(begin: 1.0, end: 1.2), weight: 50),
                TweenSequenceItem(
                    tween: Tween(begin: 1.2, end: 1.0), weight: 50),
              ]).animate(controller),
              child: Transform.rotate(
                angle: controller.value * 2.0 * pi,
                child: child,
              ),
            );
          },
        ),
        SizedBox(height: 30),
        Text(
          noTasks,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white54,
              decoration: TextDecoration.none,
              fontSize: 25,
              fontFamily: 'rubik'),
        )
      ],
    ));
  }
}
