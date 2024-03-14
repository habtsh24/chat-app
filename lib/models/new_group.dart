import 'package:cloud_firestore/cloud_firestore.dart';

class NewGroup {
  final String adminId;
  final String groupName;
  final Timestamp timestamp;
  final bool isAdmin;

  NewGroup(this.adminId, this.groupName, this.timestamp,this.isAdmin);

  Map<String, dynamic> newGroupMap() {
    return {
      'adminId': adminId,
      'groupName': groupName,
      'timestamp': timestamp,
      'isAdmin':isAdmin,
    };
  }
}
