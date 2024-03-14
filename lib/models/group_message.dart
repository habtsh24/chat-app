import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMessage {
  final String senderEmail;
  final String senderName;
  final String message;
  final Timestamp timestamp;

  GroupMessage(this.senderEmail, this.senderName, this.message, this.timestamp);

  Map<String, dynamic> groupMessageMap() {
    return {
   'senderEmail':senderEmail,
   'senderName':senderName,
   'message':message,
   'timestamp':timestamp,

    };
  }
}
