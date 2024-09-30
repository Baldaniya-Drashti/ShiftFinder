import 'dart:async';
import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/chat/i_chat_service.dart';
import 'package:shift/infrastructure/core/chat/message_response.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

@injectable
class SocketChatService extends ChatService {
  late io.Socket socket;
  late String roomId;
  final StreamController<bool> _socketConnectController =
      StreamController<bool>();
  final StreamController<MessageData> _newMessageController =
      StreamController<MessageData>();

  @override
  Stream<List<MessageData>> getMessages() {
    throw UnimplementedError();
  }

  SocketChatService() {
    socket = io.io('http://157.245.106.111:3010/',
        io.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      log('Socket Connected');
      _socketConnectController.add(true);
    });
    socket.onConnecting((data) => log('Socket Connecting'));
    socket.onDisconnect((data) => log('Socket Disconnected'));
    try {
      socket.on('newMessage', (data) {
        if (data != null) {
          // log('Message ID ${data['message_id'].runtimeType}');
          // log('Sendeer ID ${data['senderId'].runtimeType}');
          // log('Received id ${data['receiverId'].runtimeType}');
          // log('Message ${data['message'].runtimeType}');
          // log('Type ${data['type'].runtimeType}');
          // log('Created at ${data['created_at'].runtimeType}');
          var messageObject = MessageData(
            id: data['message_id'],
            senderId: int.parse(data['senderId']),
            receiverId: int.parse(data['receiverId']),
            message: data['message'],
            type: data['type'],
            createdAt: data['created_at'],
          );
          _newMessageController.add(messageObject);
        }
      });
    } catch (e) {
      log('Socket Error $e');
    }
  }

  Stream<bool> get socketConnectStream => _socketConnectController.stream;
  Stream<MessageData> get newMessageStream => _newMessageController.stream;
  void connectToSocket() {
    socket.connect();
  }

  @override
  void createRoom(String sender, String receiver) {
    socket.emit('createRoom', {
      'senderId': sender,
      'receiverId': receiver,
      'chatType': '1',
    });
    socket.on('roomConnected', (data) {
      roomId = data.toString();
      log('Room Connected ${data.toString()}');
    });
  }

  @override
  Future<void> sendMessage(MessageData message) async {
    socket.emit('sendMessage', {
      'message': message.message,
      'type': message.type,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'roomId': roomId,
    });
  }
}
