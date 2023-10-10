import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService implements INetworkService {
  @override
  Future<bool> isOnline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }
}
