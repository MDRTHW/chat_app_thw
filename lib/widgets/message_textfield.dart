import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField({required this.currentId, required this.friendId});
  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Type your message",
                    // labelText: "Message",
                    // fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                      gapPadding: 10,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () async {
                  String message = _controller.text;

                  _controller.clear();
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('chats')
                      .add({
                    "senderId": widget.currentId,
                    "receiverId": widget.friendId,
                    "message": message,
                    "type": "text",
                    "date": DateTime.now()
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.currentId)
                        .collection('messages')
                        .doc(widget.friendId)
                        .set({
                      'last_msg': message,
                    });
                  });

                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.friendId)
                      .collection('messages')
                      .doc(widget.currentId)
                      .collection('chats')
                      .add({
                    "senderId": widget.currentId,
                    "receiverId": widget.friendId,
                    "message": message,
                    "type": "text",
                    "date": DateTime.now()
                  }).then((value) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.friendId)
                        .collection('messages')
                        .doc(widget.currentId)
                        .set({
                      'last_msg': message,
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
                  child: Icon(
                    Icons.send_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
