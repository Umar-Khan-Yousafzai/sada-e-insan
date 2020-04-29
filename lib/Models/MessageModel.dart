import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String receiverId;
  String message;
  String type;
  String imageUrl;
  FieldValue timestamp;

  Message(
      {this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp});

  Message.imageMessage(
      {this.imageUrl,
      this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.timestamp});

  Map toMessageMap() {
    var message = Map<String, dynamic>();
    message['senderId'] = this.senderId;
    message['receiverId'] = this.receiverId;
    message['message'] = this.message;
    message['type'] = this.type;
    message['imageUrl'] = this.imageUrl;
    message['timestamp'] = this.timestamp;
    return message;
  }

  Message fromMap(Map<String, dynamic> message) {
    Message _message = Message();
    _message.senderId = message['senderId'];
    _message.receiverId = message['receiverId'];
    _message.message = message['message'];
    _message.type = message['type'];
    _message.imageUrl = message['imageUrl'];
    _message.timestamp = message['timestamp'];

    return _message;
  }
}
