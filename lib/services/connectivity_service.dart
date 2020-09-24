import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  static Future<bool> getConnectivityStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('No connection.');
      return false;
    } else {
      return true;
    }
  }
}
