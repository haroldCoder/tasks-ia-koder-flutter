import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

/// @deprecated This class is deprecated and will be removed in a future version.
/// Use the new hexagonal architecture providers instead:
/// - `connectionStatusProvider` for full connection status with type
/// - `connectionTypeProvider` for connection type only
/// 
/// Migration example:
/// ```dart
/// // Old way:
/// final type = ref.watch(connectionWifiProvider);
/// 
/// // New way:
/// final type = ref.watch(connectionTypeProvider);
/// ```
@Deprecated('Use connectionTypeProvider or connectionStatusProvider instead')
class ConnectionWifiNotifier extends StateNotifier<ConnectionType> {
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  ConnectionWifiNotifier() : super(ConnectionType.empty) {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      state = _mapResultToConnectionType(result[0]);
    });
    _initialCheck();
  }

  void _initialCheck() async {
    final result = await Connectivity().checkConnectivity();
    state = _mapResultToConnectionType(result[0]);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

ConnectionType _mapResultToConnectionType(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.wifi:
      return ConnectionType.wifi;
    case ConnectivityResult.mobile:
      return ConnectionType.mobile;
    default:
      return ConnectionType.empty;
  }
}
