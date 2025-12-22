import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectionGlobal extends Notifier<bool> {
  @override
  bool build() {
    _listenConnectivity();
    return false;
  }

  void _listenConnectivity() {
    final connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      final isConnected =
          result.contains(ConnectivityResult.wifi) ||
              result.contains(ConnectivityResult.mobile);

      state = isConnected;
    });
  }

  void refreshStatus(bool change){
    state = change;
  }

  void saveTypeConnection(ConnectionType type) {
    ref.read(typeConnectionProvider.notifier).state = type;
  }
}
