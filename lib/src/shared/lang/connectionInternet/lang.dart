import 'package:easy_localization/easy_localization.dart';
import 'package:tasks_ia_koderx/src/shared/States/ConnectionWifi/enums/connectionType.dart';

Map<ConnectionType, String> status = {
  ConnectionType.wifi: tr('connection.wifi'),
  ConnectionType.mobile: tr('connection.mobile'),
  ConnectionType.empty: tr('connection.empty')
};