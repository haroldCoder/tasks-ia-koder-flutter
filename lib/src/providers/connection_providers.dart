import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionGlobal.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionWifi.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

final typeConnectionProvider = StateProvider<ConnectionType>((ref) {
  return ConnectionType.empty;
});

final connectionGlobalProvider = NotifierProvider<
    ConnectionGlobal, bool>(() {
  return ConnectionGlobal();
});

final connectionWifiProvider =
    StateNotifierProvider<ConnectionWifiNotifier, ConnectionType>((ref) {
  return ConnectionWifiNotifier();
});
