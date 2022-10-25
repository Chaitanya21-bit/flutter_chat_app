import 'package:flutter/material.dart';
import 'package:flutter_chat_app/methods/method.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            logOut(context);
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
