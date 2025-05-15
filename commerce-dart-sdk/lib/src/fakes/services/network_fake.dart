// coverage:ignore-file
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FakeNetworkService implements INetworkService {
  final bool _isOnline;
  FakeNetworkService(this._isOnline);

  @override
  Future<bool> isOnline() async => _isOnline;
}
