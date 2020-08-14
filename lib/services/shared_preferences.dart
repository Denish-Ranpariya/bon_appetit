import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<void> setLoginStatus(bool status) async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('loginStatus', status);
  }

  Future<bool> getLoginStatus() async {
    final SharedPreferences _pref = await SharedPreferences.getInstance();
    bool status = await _pref.get('loginStatus');
    if (status == null) {
      return false;
    }
    return status;
  }
}
