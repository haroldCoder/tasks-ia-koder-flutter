import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectionStatus {
  final ConnectionType type;
  final bool isConnected;
  final DateTime lastChecked;

  const ConnectionStatus({
    required this.type,
    required this.isConnected,
    required this.lastChecked,
  });

  factory ConnectionStatus.disconnected() {
    return ConnectionStatus(
      type: ConnectionType.empty,
      isConnected: false,
      lastChecked: DateTime.now(),
    );
  }

  factory ConnectionStatus.wifi() {
    return ConnectionStatus(
      type: ConnectionType.wifi,
      isConnected: true,
      lastChecked: DateTime.now(),
    );
  }

  factory ConnectionStatus.mobile() {
    return ConnectionStatus(
      type: ConnectionType.mobile,
      isConnected: true,
      lastChecked: DateTime.now(),
    );
  }

  ConnectionStatus copyWith({
    ConnectionType? type,
    bool? isConnected,
    DateTime? lastChecked,
  }) {
    return ConnectionStatus(
      type: type ?? this.type,
      isConnected: isConnected ?? this.isConnected,
      lastChecked: lastChecked ?? this.lastChecked,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConnectionStatus &&
        other.type == type &&
        other.isConnected == isConnected &&
        other.lastChecked == lastChecked;
  }

  @override
  int get hashCode {
    return type.hashCode ^ isConnected.hashCode ^ lastChecked.hashCode;
  }

  @override
  String toString() {
    return 'ConnectionStatus(type: $type, isConnected: $isConnected, lastChecked: $lastChecked)';
  }
}
