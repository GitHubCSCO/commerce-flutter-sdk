import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class MessageService extends ServiceBase implements IMessageService {
  MessageService({
    required super.clientService,
    required super.cacheService,
    required super.networkService,
  });

  static const String messageUri = '/api/v1/messages';

  @override
  Future<Result<MessageDto, ErrorResponse>> addMessage(
      MessageDto message) async {
    final data = serialize(message, (message) => message.toJson());
    return await postAsyncNoCache(messageUri, data, MessageDto.fromJson);
  }
}
