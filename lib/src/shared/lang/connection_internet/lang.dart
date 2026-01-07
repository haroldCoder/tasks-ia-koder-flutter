import 'package:easy_localization/easy_localization.dart';
import 'package:tasks_ia_koderx/src/shared/States/Connection_wifi/enums/connection_Type.dart';

Map<ConnectionType, String> get status => {
  ConnectionType.wifi: tr('connection.wifi'),
  ConnectionType.mobile: tr('connection.mobile'),
  ConnectionType.empty: tr('connection.empty')
};