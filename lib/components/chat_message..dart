
import 'package:flutter/material.dart';



class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;

  const ChatMessage({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.blue
              : Colors.green, 
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
