import 'package:flutter/material.dart';
import 'package:flutter_chat_app/methods/method.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';
import 'package:flutter_chat_app/screens/signup_screen.dart';

import 'package:flutter_chat_app/widgets/field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
              alignment: Alignment.centerLeft,
              width: size.width / 1.2,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              )),
          SizedBox(
            height: size.height / 20,
          ),
          SizedBox(
            width: size.width / 1.3,
            child: const Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
            ),
          ),
          SizedBox(
            width: size.width / 1.3,
            child: const Text(
              "Sign In To Continue!!",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            width: size.width,
            alignment: Alignment.center,
            child: field(size, "E-mail", Icons.account_box, email),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Container(
              width: size.width,
              alignment: Alignment.center,
              child: field(size, "Password", Icons.lock, password),
            ),
          ),
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 14,
            width: size.width / 5,
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                if (email.text.isNotEmpty && password.text.isNotEmpty) {
                  logIn(email.text, password.text).then((user) {
                    if (user != null) {
                      print("login done");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                    } else
                      print("login failed");
                  });
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 40,
          ),
          SizedBox(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text(
                "New User? Create Account",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                    color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }
}
