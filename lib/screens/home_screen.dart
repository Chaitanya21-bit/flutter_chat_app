import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/methods/method.dart';
import 'package:flutter_chat_app/screens/chat_room.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Map<String?, dynamic>? userMap;
  final TextEditingController search = TextEditingController();

  String chatRoomId(String user1, String user2) {
    if (user1.toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void onSearch() async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .where("email", isEqualTo: search.text)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
        });
        print(userMap);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () => logOut(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.2,
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Container(
            height: size.height / 14,
            width: size.width / 3,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: onSearch,
              child: const Text(
                "Search",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Container(
            child: userMap != null
                ? ListTile(
                    onTap: () {
                      print(auth.currentUser!);
                      print(userMap!['name']);
                      String roomId = chatRoomId(
                          auth.currentUser!.displayName!, userMap!['name']);
                      print(roomId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatRoom(
                                  chatRoomId: roomId,
                                  userMap: userMap!,
                                )),
                      );
                    },
                    leading: const Icon(Icons.account_box, color: Colors.black),
                    title: Text(userMap!['name']),
                    subtitle: Text(userMap!['email']),
                    trailing: const Icon(Icons.chat, color: Colors.black),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
