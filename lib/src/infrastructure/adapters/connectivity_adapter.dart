import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tasks_ia_koderx/src/application/ports/connection_monitor_port.dart';
import 'package:tasks_ia_koderx/src/domain/entities/connection_status.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectivityAdapter implements ConnectionMonitorPort {
  final Connectivity _connectivity;
  late final StreamController<ConnectionStatus> _statusController;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityAdapter({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity() {
    _statusController = StreamController<ConnectionStatus>.broadcast();
    _initialize();
  }

  void _initialize() {
    _checkAndEmitStatus();
    _subscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final status = _mapResultsToConnectionStatus(results);
        _statusController.add(status);
      },
      onError: (error) {
        _statusController.add(ConnectionStatus.disconnected());
      },
    );
  }

  Future<void> _checkAndEmitStatus() async {
    try {
      final status = await checkCurrentStatus();
      _statusController.add(status);
    } catch (e) {
      _statusController.add(ConnectionStatus.disconnected());
    }
  }

  @override
  Stream<ConnectionStatus> get connectionStream => _statusController.stream;

  @override
  Future<ConnectionStatus> checkCurrentStatus() async {
    try {
      final results = await _connectivity.checkConnectivity();
      return _mapResultsToConnectionStatus(results);
    } catch (e) {
      return ConnectionStatus.disconnected();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _statusController.close();
  }

  ConnectionStatus _mapResultsToConnectionStatus(
      List<ConnectivityResult> results) {
    if (results.isEmpty) {
      return ConnectionStatus.disconnected();
    }

    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectionStatus.wifi();
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectionStatus.mobile();
    }

    if (results.contains(ConnectivityResult.ethernet)) {
      return ConnectionStatus(
        type: ConnectionType.wifi,
        isConnected: true,
        lastChecked: DateTime.now(),
      );
    }

    return ConnectionStatus.disconnected();
  }
}
