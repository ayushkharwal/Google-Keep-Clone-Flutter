import 'package:flutter/cupertino.dart';

class HomeScreenProvider with ChangeNotifier {
  bool _internetConnectivity = true;
  bool _syncSwitchVal = true;

  bool get internetConnectivity => _internetConnectivity;

  set internetConnectivity(bool value) {
    _internetConnectivity = value;
    notifyListeners();
  }

  bool get syncSwitchVal => _syncSwitchVal;

  set syncSwitchVal(bool value) {
    _syncSwitchVal = value;
    notifyListeners();
  }
}
