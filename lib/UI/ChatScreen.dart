import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'ChatScreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Chatty'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MessagesStream(),
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: Colors.blue[900],
                border: Border.all(color: Colors.blue)),
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 2,
                    ),
                    IconButton(
                        onPressed: () {},
                        tooltip: 'Take a Photo from Camera',
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 1,
                    ),
                    IconButton(
                        onPressed: () {},
                        tooltip: 'Choose Picture from Gallery',
                        icon: Icon(
                          Icons.photo,
                          color: Colors.white,
                        )),
                  ],
                ),
                Expanded(
                    child: TextField(
                  controller: messageTextController,
                  onChanged: (value) {
                    messageText = value;
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message here...',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                      contentPadding: EdgeInsets.all(10)),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    onPressed: () {
                      //message text + loggedInUser.email
                      messageTextController.clear();
                      _fireStore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.blue[900],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.white,
                    highlightColor: Colors.blue[600],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fireStore.collection("messages").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
              ),
            );
          }
          final messages = snapshot.data.docs.reversed;
          List<MessageBubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];
            final currentUser = loggedInUser.email;
            if (currentUser == messageSender) {
              // the message from loggedIn User
            }
            final messageBubble = MessageBubble(
              text: messageText,
              sender: messageSender,
              isMe: currentUser == messageSender,
            );
            messageBubbles.add(messageBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  MessageBubble({this.sender, this.text,this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))
                    : BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
            color: isMe ? Colors.blue[800] : Colors.blue[300],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.blue[900],
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}