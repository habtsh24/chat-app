import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage {
  final String senderEmail;
  final String senderId;
  final String reciverId;
  final String message;
  final Timestamp timeStamp;

  NewMessage(this.senderEmail, this.senderId, this.reciverId,this.message,
      this.timeStamp);
  Map<String, dynamic> messageMap() {
    return {
      'senderEmail': senderEmail,
      'senderId': senderId,
      'reciverId': reciverId,
      'message':message,
      'timestamp': timeStamp,
    };
  }
}
