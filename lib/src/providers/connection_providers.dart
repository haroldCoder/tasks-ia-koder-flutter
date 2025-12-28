import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tasks_ia_koderx/src/application/ports/connection_monitor_port.dart';
import 'package:tasks_ia_koderx/src/application/usecases/monitor_connection_usecase.dart';
import 'package:tasks_ia_koderx/src/domain/entities/connection_status.dart';
import 'package:tasks_ia_koderx/src/infrastructure/adapters/connectivity_adapter.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionGlobal.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionWifi.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

final connectionMonitorPortProvider = Provider<ConnectionMonitorPort>((ref) {
  final adapter = ConnectivityAdapter();
  
  ref.onDispose(() {
    adapter.dispose();
  });
  
  return adapter;
});

final monitorConnectionUseCaseProvider = Provider<MonitorConnectionUseCase>((ref) {
  final port = ref.watch(connectionMonitorPortProvider);
  final useCase = MonitorConnectionUseCase(port);
  
  ref.onDispose(() {
    useCase.dispose();
  });
  
  return useCase;
});

final connectionStatusProvider = StreamProvider<ConnectionStatus>((ref) {
  final useCase = ref.watch(monitorConnectionUseCaseProvider);
  return useCase.connectionStream;
});

final connectionTypeProvider = Provider<ConnectionType>((ref) {
  final asyncStatus = ref.watch(connectionStatusProvider);
  return asyncStatus.when(
    data: (status) => status.type,
    loading: () => ConnectionType.empty,
    error: (_, __) => ConnectionType.empty,
  );
});

final isConnectedProvider = Provider<bool>((ref) {
  final asyncStatus = ref.watch(connectionStatusProvider);
  return asyncStatus.when(
    data: (status) => status.isConnected,
    loading: () => false,
    error: (_, __) => false,
  );
});


final typeConnectionProvider = StateProvider<ConnectionType>((ref) {
  final type = ref.watch(connectionTypeProvider);
  return type;
});

final connectionGlobalProvider = NotifierProvider<
    ConnectionGlobal, bool>(() {
  return ConnectionGlobal();
});

final connectionWifiProvider =
    StateNotifierProvider<ConnectionWifiNotifier, ConnectionType>((ref) {
  return ConnectionWifiNotifier();
});
