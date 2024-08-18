import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OptiLoggerService implements ILoggerService {
  final bool enableDebugLog;
  OptiLoggerService({required this.enableDebugLog});
  @override
  bool isEnabled() => enableDebugLog;
}
