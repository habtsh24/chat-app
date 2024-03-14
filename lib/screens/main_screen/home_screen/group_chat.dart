import 'package:chat_app/service/gourp_chat_service.dart';
import 'package:flutter/material.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> {
  final _groupChat = GroupChatService();

  Widget accountWidget(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // onTap: () => mainChat(email, id, name),
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Center(
            child: Icon(
              Icons.group,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
        ),
        title: Text(name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _groupChat.getGroup(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final user = snapshot.data!;
          return ListView(
            children: user.docs.map((doc) {
              Map<String, dynamic> userData =
                  doc.data() as Map<String, dynamic>;
              return accountWidget(userData['groupName']);
            }).toList(),
          );
        }
      },
    );
  }
}
