import 'package:get/get.dart';

class ConnectionGlobal extends GetxController{
  Rx<bool> connection = false.obs;

  void refreshStatus(bool change){
    connection.value = change;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    connection.close();
  }
}