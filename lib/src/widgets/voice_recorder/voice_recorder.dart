import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:tasks_ia_koderx/src/widgets/voice_recorder/utils/convert_brain_to_task.dart';

class VoiceRecorder extends ConsumerStatefulWidget {
  const VoiceRecorder({super.key, required this.widget, this.onPressed});

  final Widget widget;
  final Function(Function fn)? onPressed;

  @override
  ConsumerState<VoiceRecorder> createState() => _VoiceRecorderState();
}

class _VoiceRecorderState extends ConsumerState<VoiceRecorder> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  Timer? _closeTimer;
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _requestPermission();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _closeTimer?.cancel();
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    final speech = await Permission.speech.request();

    if (status.isGranted && speech.isGranted) {
      print('🎤 Permiso concedido');
    } else {
      print('❌ Permiso denegado');
    }
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
          _scale = 2;
        });
        _speech.listen(onResult: (val) {
          setState(() {
            _text = val.recognizedWords;
          });
        });
      }
    }
  }

  void pressedEnd() {
    _closeTimer = Timer(Duration(seconds: 2), () {
      setState(() {
        _scale = 1;
        _isListening = false;
      });
      _speech.stop();
      GoRouter.of(context).pop();
      print(_text);
      ref.read(convertBrainToTaskProvider.notifier).convert(_text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: GestureDetector(
          child: AnimatedScale(
              scale: _scale,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _isListening ? Color(0x420043D4) : Colors.transparent),
                child: widget.widget,
              )),
          onLongPressStart: widget.onPressed != null
              ? (_) => widget.onPressed!(_listen)
              : null,
          onLongPressEnd: (_) {
            pressedEnd();
          },
        ));
  }
}
