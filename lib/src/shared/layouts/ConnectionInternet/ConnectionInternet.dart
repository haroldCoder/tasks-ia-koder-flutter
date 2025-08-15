import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionGlobal.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/ConnectionWifi.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';
import 'package:tasks_ia_koderx/src/shared/lang/connectionInternet/lang.dart';
import 'package:tasks_ia_koderx/src/shared/layouts/ConnectionInternet/ConnectionStream.dart';

class ConnectionInternet extends StatefulWidget {
  const ConnectionInternet({super.key});

  @override
  State<ConnectionInternet> createState() => _ConnectionInternetState();
}

class _ConnectionInternetState extends State<ConnectionInternet> {
  ConnectionWifi connectionWifi = ConnectionWifi();
  final connectionGlobal = Get.find<ConnectionGlobal>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectionWifi.stream.listen((type) {
      connectionGlobal.saveTypeConnection(type);
      connectionGlobal.refreshStatus(type == ConnectionType.wifi
          ? true
          : type == ConnectionType.mobile
              ? true
              : false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 6,
      children: [
        ConnectionStream(),
        Obx(() => Text(status[connectionGlobal.typeConection.value].toString(),
            style: TextStyle(color: Colors.grey)))
      ],
    );
  }
}
