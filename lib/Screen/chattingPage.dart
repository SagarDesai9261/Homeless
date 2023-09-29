// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:homeless/model/model.dart';

class ChatScreen extends StatefulWidget {
  final ChatPerson chatPerson;

  ChatScreen({required this.chatPerson});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();

    List<String> chatMessages = [];
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Handle the back button action here, such as popping the current route.
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new,
                    color: Colors.grey, size: 26), // Back icon
                // Text(
                //   "Back",
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14, // Customize the font size as needed
                //   ),
                // ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.chatPerson.name.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(chatMessages[index]),
                  // Add more styling as needed
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    // Get the entered message from the text field
                    final message = _messageController.text;

                    if (message.isNotEmpty) {
                      // Add the message to the list of chat messages
                      setState(() {
                        chatMessages.add(message);
                      });

                      // Clear the text field
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
