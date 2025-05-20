import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class NetworkService implements INetworkService {
  @override
  Future<bool> isOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
