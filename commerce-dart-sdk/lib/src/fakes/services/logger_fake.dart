// coverage:ignore-file
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FakeLoggerService implements ILoggerService {
  final bool _isEnabled;
  FakeLoggerService(this._isEnabled);
  @override
  bool get isApiLogEnabled => _isEnabled;
}
