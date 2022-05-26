import 'package:chat_app/view/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

late User signedinUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messagetext;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedinUser = user;
        print(signedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessagesStreams() async {
    await for (var snappshot in _firestore.collection("messages").snapshots()) {
      for (var message in snappshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: primaryColor,
        title: const Text("Quick message"),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      body: ConditionalBuilder(
        builder:(context)=> SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection("messages")
                      .orderBy("time")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<MessageCard> messageWidgets = [];
                    final messages = snapshot.data!.docs.reversed;
                    for (var message in messages) {
                      final mssgtxt = message.get("text");
                      final mssgsender = message.get("sender");
                      final currentUser = signedinUser.email;

                      final messageWidget = MessageCard(
                        sender: mssgsender,
                        text: mssgtxt,
                        isMine: currentUser == mssgsender,
                      );
                      messageWidgets.add(messageWidget);
                    }
                    return Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        children: messageWidgets,
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                        color: primaryColor,
                        width: 2,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextField(
                            controller: messageController,
                            onChanged: (value) {
                              messagetext = value;
                            },
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                hintText: "write your message here",
                                border: InputBorder.none),
                          )),
                      TextButton(
                          onPressed: () {
                            messageController.clear();
                            _firestore.collection("messages").add({
                              "text": messagetext,
                              "sender": signedinUser.email,
                              "time": FieldValue.serverTimestamp()
                            });
                          },
                          child: Icon(
                            Icons.send,
                            color: purple,
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        condition: true,
        fallback:(context)=> Center(child: CircularProgressIndicator()),

      ),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({this.text, this.sender, required this.isMine, Key? key})
      : super(key: key);
  final String? sender;
  final String? text;
  final bool isMine;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          //Text("$sender"),
          Material(
              elevation: 3,
              borderRadius: isMine
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
              color: isMine ? primaryColor : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "$text",
                  style: TextStyle(
                      fontSize: 20,
                      color: isMine ? Colors.white : Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
