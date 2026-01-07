import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';
import 'package:tasks_ia_koderx/src/shared/lang/connection_internet/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/connection_watch.dart';

class ConnectionInternet extends ConsumerWidget {
  const ConnectionInternet({super.key, this.decoration, this.font});
  final TextDecoration? decoration;
  final String? font;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionGlobal = ref.watch(connectionWifiProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ConnectionWatch(),
        const SizedBox(width: 6),
        Text(
          status[connectionGlobal]?.toString() ?? '',
          style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              decoration: decoration,
              fontFamily: font),
        ),
      ],
    );
  }
}
