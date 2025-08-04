import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/widgets/Button/shared/class/button.dart';

class Overlayfixed extends StatefulWidget {
  const Overlayfixed(
      {super.key, required this.widget, required this.bottom, required this.right, this.left, this.top});

  final Widget widget;
  final double? top;
  final double bottom;
  final double right;
  final double? left;

  @override
  State<Overlayfixed> createState() => _OverlayFixedState();
}

class _OverlayFixedState extends State<Overlayfixed> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: widget.bottom,
        right: widget.right,
        left: widget.left,
        top: widget.top,
        child: Material(
          color: Colors.transparent,
          child: widget.widget,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
