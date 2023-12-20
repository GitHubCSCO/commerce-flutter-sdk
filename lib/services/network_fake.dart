import 'package:test/fake.dart';

import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

class FakeNetworkService extends Fake implements INetworkService {
  bool _isOnline;
  FakeNetworkService(this._isOnline);

  @override
  Future<bool> isOnline() async => _isOnline;
}
