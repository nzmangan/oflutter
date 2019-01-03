import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  Future<String> get() async {
    var r = await Connectivity().checkConnectivity();
    if (r == ConnectivityResult.mobile) {
      return 'mobile';
    } else if (r == ConnectivityResult.wifi) {
      return 'wifi';
    }

    return 'none';
  }
}
