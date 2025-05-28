import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

abstract class IMessageService {
  Future<Result<MessageDto, ErrorResponse>> addMessage(MessageDto message);
}
