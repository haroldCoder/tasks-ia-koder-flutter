import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_ia_koderx/src/providers/connection_providers.dart';

class ConnectionInitializer extends ConsumerStatefulWidget {
  final Widget child;
  
  const ConnectionInitializer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  ConsumerState<ConnectionInitializer> createState() => _ConnectionInitializerState();
}

class _ConnectionInitializerState extends ConsumerState<ConnectionInitializer> {
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(connectionStatusProvider);
      
      debugPrint('🌐 Connection monitoring system initialized');
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(connectionStatusProvider, (previous, next) {
      next.whenData((status) {
        debugPrint('🌐 Connection status changed: ${status.type} (connected: ${status.isConnected})');
      });
    });

    return widget.child;
  }
}
