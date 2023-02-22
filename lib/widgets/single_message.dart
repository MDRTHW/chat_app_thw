import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  SingleMessage({required this.message, required this.isMe});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(13),
          margin: EdgeInsets.all(5),
          constraints: BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color: isMe ? Colors.grey.shade300 : Colors.teal.shade300,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
