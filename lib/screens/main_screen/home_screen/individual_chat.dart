import 'package:chat_app/screens/main_screen/chat_page.dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:chat_app/service/chat_sevice.dart';
import 'package:flutter/material.dart';

class IndividualChat extends StatefulWidget {
  const IndividualChat({super.key});

  @override
  State<IndividualChat> createState() => _HomePageState();
}

class _HomePageState extends State<IndividualChat> {
  final _chatService = ChatService();
  final _authService = AuthService();

  mainChat(String reciverEmail, reciverId, name) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            reciverEmail: reciverEmail,
            reciverId: reciverId,
            reciverName: name,
          ),
        ));
  }

  List<Widget> accountList(List<Map<String, dynamic>> users) {
    List<Widget> widgetList = [];

    for (Map user in users) {
      if (user['email'] != _authService.getCurrentUser()!.email) {
        widgetList.add(accountWidget(user['email'], user['uid'], user['name']));
      } else {
        continue;
      }
    }
    return widgetList;
  }

  Widget accountWidget(String email, id, name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.primaryContainer,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () => mainChat(email, id, name),
        leading: CircleAvatar(
          radius: 18,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Center(
            child: Icon(
              Icons.person,
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
      stream: _chatService.getUsersStream(),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final users = snapshot.data;
          return ListView(
            children: accountList(users!),
          );
        }
      },
    );
  }
}
