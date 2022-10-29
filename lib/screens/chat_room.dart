import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key, this.userMap, required this.chatRoomId})
      : super(key: key);

  final Map<String?, dynamic>? userMap;

  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final TextEditingController message = TextEditingController();
    final size = MediaQuery.of(context).size;

    void onSendMessage() async {
      if (message.text.isNotEmpty) {
        Map<String, dynamic> messages = {
          "sendby": auth.currentUser?.displayName,
          "message": message.text,
          "time": FieldValue.serverTimestamp()
        };
        await firestore
            .collection('chatroom')
            .doc(chatRoomId)
            .collection('chats')
            .add(messages);
      }
      message.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<DocumentSnapshot>(
          stream: firestore.collection("users").doc(userMap!['uid']).snapshots(),
            builder: (context, snapshot) {
          if (snapshot.data != null) {
            return Column(
              children: [
                Text(userMap!['name']),
                Text(snapshot.data!['status'],
                style: const TextStyle(
                  fontSize: 14
                ),)
              ],
            );
          } else {
            return Container();
          }
        }),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: size.height / 1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          return messages(size, map);
                        });
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: size.height / 12,
                width: size.width / 1.1,
                child: Row(
                  children: [
                    SizedBox(
                      height: size.height / 12,
                      width: size.width / 1.35,
                      child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                            hintText: 'Write Message',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    IconButton(
                        onPressed: onSendMessage, icon: const Icon(Icons.send))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Container(
      width: size.width,
      alignment: map['sendby'] == auth.currentUser?.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.blue),
        child: Text(
          map['message'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
