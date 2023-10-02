import 'package:flutter/material.dart';
import 'package:homeless/Screen/triangleUIChat.dart';
import 'package:homeless/model/model.dart';

class ChatScreen extends StatefulWidget {
  final ChatPerson chatPerson;

  ChatScreen({required this.chatPerson});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool isSender = true; // Track the current message type

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      isSender: isSender, // Use the current message type
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              maxLines: null,
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                  hintText: 'Type your message',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.swap_horiz,
              color: Colors.grey,
            ), // Add a button to switch message type
            onPressed: () {
              setState(() {
                isSender = !isSender;
              });
            },
          ),
          InkWell(
            onTap: () {
              _handleSubmitted(_textController.text);
            },
            child: SizedBox(
              height: 28,
              child: Image(
                image: AssetImage('assets/send.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.chatPerson.name.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true, // Start from the bottom of the list
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _messages[index];
              },
            ),
          ),
          Divider(height: 1.0),
          _buildTextComposer(),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSender;

  ChatMessage({required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    final bool shouldWrapText =
        text.length > 25; // Determine if text should wrap
    final BorderRadius messageBorderRadius = BorderRadius.only(
      topLeft:
          Radius.circular(isSender ? 18.0 : 0), // Round top-left for sender
      topRight:
          Radius.circular(isSender ? 0 : 16.0), // Round top-right for receiver
      bottomLeft: Radius.circular(16.0), // Always round bottom-left
      bottomRight: Radius.circular(16.0), // Always round bottom-right
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width *
                  0.7, // Set a maximum width
            ),
            decoration: BoxDecoration(
              color: isSender ? Colors.white : Colors.blueGrey,
              borderRadius: messageBorderRadius,
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
              text,
              style: TextStyle(
                color: isSender ? Colors.black : Colors.white,
              ),
              maxLines: shouldWrapText ? null : 1, // Allow text to wrap
              overflow:
                  shouldWrapText ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
