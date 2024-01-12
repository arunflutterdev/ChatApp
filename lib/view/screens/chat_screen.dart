import 'package:chat_app/constants.dart';
import 'package:chat_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/firebase_provider.dart';
import '../widgets/chat_messages.dart';
import '../widgets/chat_text_field.dart';

import 'package:string_capitalize/string_capitalize.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userId});

  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(receiverId: widget.userId),
            ChatTextField(receiverId: widget.userId)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
    backgroundColor:mainColor,
      elevation: 0,
      foregroundColor: Colors.white,
      title: Consumer<FirebaseProvider>(
        builder: (context, value, child) => value.user != null
            ? Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(value.user!.image),
                    radius: 22,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        value.user!.name.capitalize(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            ),
                      ),
                      Text(
                        value.user!.isOnline ? 'Online' : 'Offline',
                        style: TextStyle(
                          color: value.user!.isOnline
                              ? Colors.green
                              : Colors.black,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.call, color: Colors.white),
                    onPressed: () {},
                    // => _sendText(context),
                  ),
                 IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.videocam, color: Colors.white),
                    onPressed: () {},
                    // => _sendText(context),
                  ),
                ],
              )
            : const SizedBox(),
      ));
}
