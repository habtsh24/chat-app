import 'package:chat_app/models/new_message.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();

  Future<void> sendMessage(String reciverId, message) async {
    final currentUserId = _authService.getCurrentUser()!.uid;
    final currentUserEmail = _authService.getCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    final newMessage = NewMessage(
        currentUserEmail, currentUserId, reciverId, message, timestamp);

    List<String> chatRoomIdList = [currentUserId, reciverId];
    chatRoomIdList.sort();
    final chatRoomId = chatRoomIdList.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.messageMap());
  }

  Stream<QuerySnapshot> getMessage(String senderId, reciverId) {
    List chatRoomIdList = [senderId, reciverId];
    chatRoomIdList.sort();
    final chatRoomId = chatRoomIdList.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy(
          'timestamp',
          descending: false,
        ).snapshots();
  }

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }
}
