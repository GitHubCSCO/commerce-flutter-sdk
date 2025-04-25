import 'package:commerce_flutter_sdk/features/domain/service/interfaces/interfaces.dart';

class OptiLogger implements OptiLoggerService {
  final bool _enableApiLog;
  final bool _enableDebugLog;
  final bool _enableErrorLog;

  OptiLogger({
    enableApiLog = false,
    enableDebugLog = false,
    enableErrorLog = false,
  })  : _enableApiLog = enableApiLog,
        _enableDebugLog = enableDebugLog,
        _enableErrorLog = enableErrorLog;

  @override
  bool get isApiLogEnabled => _enableApiLog;

  @override
  bool get isDebugLogEnabled => _enableDebugLog;

  @override
  bool get isErrorLogEnabled => _enableErrorLog;
}
