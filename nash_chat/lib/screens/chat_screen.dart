import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:nash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? msgText;
  final msgTxtCtrl = TextEditingController();
  void GetCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    GetCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                // getMsgs();
                // msgsStream();
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: msgTxtCtrl,
                      onChanged: (value) => msgText = value,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      // print(msgText);
                      // print(loggedInUser!.email);
                      // print(Timestamp.now().toDate().toString());
                      msgTxtCtrl.clear();
                      try {
                        _firestore.collection('messages').add(<String, String?>{
                          'text': msgText,
                          'sender': loggedInUser!.email,
                          'ts': Timestamp.now().toDate().toString(),
                        }).then((value) => print("messages Added"));
                      } catch (error) {
                        print("Failed to add user: $error");
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy("ts").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
        final msgs = snapshot.data!.docs;
        List<MsgPubble> msgsPubbles = [];
        msgs.forEach((e) {
          final txt = e.data()['text'];
          final sndr = e.data()['sender'];
          msgsPubbles.add(MsgPubble(
            PubbleSender: sndr,
            pubbleText: txt,
          ));
        });
        // return Column(children: msgsWdgt);
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: msgsPubbles,
          ),
        );
      },
    );
  }
}

class MsgPubble extends StatelessWidget {
  const MsgPubble(
      {super.key, required this.pubbleText, required this.PubbleSender});
  final String pubbleText;
  final String PubbleSender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '$PubbleSender',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          SizedBox(height: 3.0),
          Material(
            color: Colors.lightBlue,
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                '$pubbleText',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(30.0),
        //   topRight: Radius.circular(30.0),
        //   bottomRight: Radius.circular(30.0),
        //   bottomLeft: Radius.circular(30.0),
        // ),


  // void getMsgs() async {
  //   final msgs = await _firestore.collection('messages').get();
  //   msgs.docs.forEach((e) {
  //     print(e.data());
  //   });
  // }

  // void msgsStream() async {
  //   await for (var msgSnapShot
  //       in _firestore.collection('messages').snapshots()) {
  //     msgSnapShot.docs.forEach((e) {
  //       print(e.data());
  //     });
  //   }
  // }
