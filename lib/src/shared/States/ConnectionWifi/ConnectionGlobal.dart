import 'package:get/get.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectionGlobal extends GetxController{
  Rx<bool> connection = false.obs;
  Rx<ConnectionType> typeConection = ConnectionType.empty.obs;

  void refreshStatus(bool change){
    connection.value = change;
  }

  void saveTypeConnection(ConnectionType type){
    typeConection.value = type;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    connection.close();
  }
}