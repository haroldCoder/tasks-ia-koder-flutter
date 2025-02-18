import 'dart:math';

import 'package:flutter/material.dart';

class Animations extends StatefulWidget{
  Animations({super.key, this.duration, required this.child, required this.transitionBuilder});

  Duration? duration;
  Widget child;
  dynamic transitionBuilder;

  @override
 _AnimationsState createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return widget.transitionBuilder(child, _controller);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}