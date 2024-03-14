import 'package:chat_app/components/chat_message..dart';
import 'package:chat_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/service/chat_sevice.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.reciverEmail, required this.reciverId, required this.reciverName})
      : super(key: key);

  final String reciverEmail;
  final String reciverId;
  final String reciverName;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  _onSend() {
    if (_formKey.currentState!.validate()) {
      final message = _controller.text;
      _chatService.sendMessage(reciverId, message);

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final senderId = _authService.getCurrentUser()!.uid;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
        title: Text(reciverName),
        actions: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessage(senderId, reciverId),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  final user = snapshot.data!;
                  return ListView(
                    children: user.docs.map((doc) {
                      Map<String, dynamic> userData =
                          doc.data() as Map<String, dynamic>;
                      return userData['senderEmail'] ==
                              _authService.getCurrentUser()!.email
                          ? ChatMessage(
                              text: userData['message'],
                              isMe: true,
                            )
                          : ChatMessage(text: userData['message'], isMe: false);
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Type your message...',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'please write something in your mind';
                          }
                          return null;
                        },
                      )),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _onSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
