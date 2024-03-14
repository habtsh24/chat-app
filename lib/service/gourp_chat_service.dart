import 'package:chat_app/models/new_group.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> newGroup(String groupName, personId, isAdmin) async {
    final timestamp = Timestamp.now();

    final newGroup = NewGroup(personId, groupName, timestamp, isAdmin);
    
    await _firestore
        .collection('groups')
        .add(newGroup.newGroupMap());
  }
  Stream<QuerySnapshot> getGroup() {
    return _firestore
        .collection('groups')
        .orderBy(
          'timestamp',
          descending: false,
        ).snapshots();
  }


}
