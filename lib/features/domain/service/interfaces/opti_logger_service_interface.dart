import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class OptiLoggerService implements ILoggerService {
  bool get isDebugLogEnabled;
  bool get isErrorLogEnabled;
}
