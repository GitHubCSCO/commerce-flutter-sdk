import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/fake.dart';

class FakeNetworkService extends Fake implements INetworkService {
  bool _isOnline;
  FakeNetworkService(this._isOnline);

  @override
  Future<bool> isOnline() async => _isOnline;
}
