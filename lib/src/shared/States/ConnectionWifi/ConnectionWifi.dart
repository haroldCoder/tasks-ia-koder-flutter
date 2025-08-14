import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

class ConnectionWifi {
  StreamController<ConnectionType> _controller = StreamController<ConnectionType>.broadcast();
  late StreamSubscription _subscription;

  Stream<ConnectionType> get stream => _controller.stream;

  ConnectionWifi(){
    _subscription = Connectivity().onConnectivityChanged.listen((result) async{
      await _emmitConnection(result[0]);
    });
  }

  Future<void> _emmitConnection(ConnectivityResult result) async{
    try{
      if(result == ConnectivityResult.wifi){
        _controller.add(ConnectionType.wifi);
      }
      else if(result == ConnectivityResult.mobile){
        _controller.add(ConnectionType.mobile);
      }
      else{
        _controller.add(ConnectionType.empty);
      }
    }
    catch(err){
      _controller.addError(err);
    }
  }

  Future<void> verifyConnection() async{
    var result = await Connectivity().checkConnectivity();
    await this._emmitConnection(result[0]);
  }
}