import 'package:tasks_ia_koderx/src/application/ports/connection_monitor_port.dart';
import 'package:tasks_ia_koderx/src/domain/entities/connection_status.dart';

class MonitorConnectionUseCase {
  final ConnectionMonitorPort _connectionMonitorPort;

  MonitorConnectionUseCase(this._connectionMonitorPort);
  Stream<ConnectionStatus> get connectionStream =>
      _connectionMonitorPort.connectionStream;

  Future<ConnectionStatus> checkCurrentStatus() {
    return _connectionMonitorPort.checkCurrentStatus();
  }
  void dispose() {
    _connectionMonitorPort.dispose();
  }
}
