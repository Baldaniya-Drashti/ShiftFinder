import 'dart:async';
import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:shift/domain/chat/i_chat_service.dart';
import 'package:shift/domain/core/environment/base_config.dart';
import 'package:shift/infrastructure/core/chat/message_response.dart';
import 'package:shift/injection.dart';
import 'package:shift/presentation/core/enum.dart';
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
    log("SocketChatService constructor called");
    socketConnection = SocketConnectionStatus.disconnected;
    socket = io.io(
        // dotenv.env['DEV_SOCKET_URL']!,
        getIt<BaseConfig>().socketHost,
        io.OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      log('Socket Connected ---> ${socket.connected}');
      socketConnection = SocketConnectionStatus.connected;
      _socketConnectController.add(true);
    });

    socket.onConnecting((data) {
      log('Socket Connecting ---> ${socket.connected}');
      socketConnection = SocketConnectionStatus.disconnected;
      _socketConnectController.add(false);
    });

    socket.onDisconnect((data) {
      log('Socket Disconnected ---> ${socket.connected}');
      socketConnection = SocketConnectionStatus.disconnected;
      _socketConnectController.add(false);
    });

    socket.onConnectError((data) {
      log('Socket Connect Error ---> ${socket.connected}');
      socketConnection = SocketConnectionStatus.disconnected;
      _socketConnectController.add(false);
    });

    socket.onError((data) {
      log('Socket Error ---> ${socket.connected}');
      socketConnection = SocketConnectionStatus.disconnected;
      _socketConnectController.add(false);
    });

    try {
      socket.on('newMessage', (data) {
        //please runtime every filed
        log('ID => ${data['message_id'].runtimeType}');
        log('senderId => ${data['senderId'].runtimeType}');
        log('receiverId => ${data['receiverId'].runtimeType}');
        // log('message_id => ${data['message_id'].runtimeType}');
        log('message => ${data['message'].runtimeType}');
        log('type => ${data['type'].runtimeType}');
        log('created_at => ${data['created_at'].runtimeType}');
        log('thumbnail => ${data['thumbnail'].runtimeType}');
        log('media_name => ${data['media_name'].runtimeType}');

        if (data != null) {
          if (data != null) {
            var messageObject = MessageData(
              id: data['message_id'],
              senderId: data['senderId'],
              receiverId: data['receiverId'],
              message: data['message'],
              type: data['type'],
              createdAt: data['created_at'] * 1000,
              thumbnail: data['thumbnail'],
              mediaName: data['media_name'],
            );
            _newMessageController.add(messageObject);
          }
        }
      });
    } catch (e) {
      log('Socket Error $e');
    }
  }

  Stream<bool> get socketConnectStream => _socketConnectController.stream;
  Stream<MessageData> get newMessageStream => _newMessageController.stream;
  void connectToSocket() {
    socketConnection = SocketConnectionStatus.disconnected;
    _socketConnectController.add(false);
    socket.connect();
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.dispose();
    socketConnection = SocketConnectionStatus.disconnected;
    _socketConnectController.add(false);
  }

  @override
  Future<bool> socketConnected() async {
    try {
      // Add a small delay to ensure socket state is updated
      await Future.delayed(const Duration(seconds: 2));

      final isActuallyConnected = socket.connected;
      final isStatusConnected =
          socketConnection == SocketConnectionStatus.connected;

      log('Socket connection check - Actual: $isActuallyConnected, Status: $isStatusConnected, Socket ID: ${socket.id}');

      return isActuallyConnected && isStatusConnected;
    } catch (e) {
      log('Error checking socket connection: $e');
      return false;
    }
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
    log('Message Data: ${message.toJson()}');
    socket.emit('sendMessage', {
      'message': message.message,
      'type': message.type,
      'senderId': message.senderId,
      'receiverId': message.receiverId,
      'roomId': roomId,
      'thumbnail': message.thumbnail,
      'media_name': message.mediaName,
    });
  }

  /*   Future<dynamic> receiveMessage() async {
    socket.on('newMessage', (data) {
      print('Check data => $data');
      return data;
    });
  } */
}
