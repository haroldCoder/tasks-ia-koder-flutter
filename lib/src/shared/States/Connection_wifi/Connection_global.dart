import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';
import 'package:tasks_ia_koderx/src/shared/States/Connection_wifi/enums/connection_Type.dart';

/// @deprecated This class is deprecated and will be removed in a future version.
/// Use the new hexagonal architecture providers instead:
/// - `connectionStatusProvider` for full connection status
/// - `isConnectedProvider` for boolean connection state
/// - `connectionTypeProvider` for connection type only
/// 
/// Migration example:
/// ```dart
/// // Old way:
/// final isConnected = ref.watch(connectionGlobalProvider);
/// 
/// // New way:
/// final isConnected = ref.watch(isConnectedProvider);
/// ```
@Deprecated('Use isConnectedProvider or connectionStatusProvider instead')
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
