import 'package:tasks_ia_koderx/src/domain/entities/connection_status.dart';

abstract class ConnectionMonitorPort {
  Stream<ConnectionStatus> get connectionStream;
  Future<ConnectionStatus> checkCurrentStatus();
  void dispose();
}
