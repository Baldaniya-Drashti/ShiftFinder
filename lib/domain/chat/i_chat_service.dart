import 'package:shift/infrastructure/core/chat/message_response.dart';

abstract class ChatService {
  Stream<List<MessageData>> getMessages();
  void createRoom(String sender, String receiver);
  Future<void> sendMessage(MessageData message);
  Future<bool> socketConnected();
}
