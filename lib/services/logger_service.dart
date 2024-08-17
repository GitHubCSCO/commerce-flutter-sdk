import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OptiLoggerService implements ILoggerService {
  bool _isEnabled;
  OptiLoggerService(this._isEnabled);

  @override
  bool isEnabled() => _isEnabled;
}
