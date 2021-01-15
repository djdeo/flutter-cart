import 'package:flutter/cupertino.dart';
import 'package:sp_util/sp_util.dart';

enum DarkMode {
  CLOSE,
  OPEN,
  FOLLOW,
}

class DarkModeProvider with ChangeNotifier {
  DarkMode _darkMode;

  DarkMode get darkMode => _darkMode;

  void changeMode(DarkMode mode) async {
    _darkMode = mode;

    notifyListeners();

    SpUtil.putObject('dark_mode', mode);
    print('🎭');
    print(mode);
    print(SpUtil.getObjectList('dark_mode'));
  }
}