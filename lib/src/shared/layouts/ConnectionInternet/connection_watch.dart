import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';
import 'package:tasks_ia_koderx/src/shared/States/Connection_wifi/enums/connection_Type.dart';

class ConnectionWatch extends ConsumerWidget {
  const ConnectionWatch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connection = ref.watch(connectionWifiProvider);

    if (connection == ConnectionType.mobile) {
      return const Icon(Icons.h_mobiledata, color: Colors.blueAccent);
    } else if (connection == ConnectionType.wifi) {
      return const Icon(Icons.wifi, color: Colors.green);
    }
    return const Icon(Icons.wifi_off, color: Colors.red);
  }
}
