import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/methods/method.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String?, dynamic>? userMap;
  final TextEditingController search = TextEditingController();

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
                    onTap: () {},
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
