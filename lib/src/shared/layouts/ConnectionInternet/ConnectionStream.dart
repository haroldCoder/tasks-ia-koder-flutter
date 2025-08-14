import 'package:flutter/material.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionWifi.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectionStream extends StatelessWidget {
  ConnectionStream({super.key});

  final ConnectionWifi connectionWifi = ConnectionWifi();

  @override
  Widget build(BuildContext context) {
    connectionWifi.verifyConnection();
    return StreamBuilder(stream: connectionWifi.stream, builder: (context, snapshot){
      if(snapshot.hasData == true){
        ConnectionType data = snapshot.data!;
        if(data == ConnectionType.mobile){
          return Icon(Icons.h_mobiledata, color: Colors.blueAccent);
        }
        else if(data == ConnectionType.wifi){
          return Icon(Icons.wifi, color: Colors.green);
        }
      }

      return Icon(Icons.wifi_off, color: Colors.red);
    });
  }
}