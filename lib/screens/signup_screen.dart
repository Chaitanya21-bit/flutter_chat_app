import 'package:flutter/material.dart';
import 'package:flutter_chat_app/methods/method.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';

import '../widgets/field.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController cfpassword = TextEditingController();


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
                    "Create Account To Continue",
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
                  child: field(size, "Name", Icons.person, name),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "E-mail", Icons.account_box, email),
                  ),
                ),
                Container(
                  width: size.width,
                  alignment: Alignment.center,
                  child: field(size, "Password", Icons.lock, password),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child:
                        field(size, "Confirm Password", Icons.lock, cfpassword),
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
                      if (name.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          password.text.isNotEmpty) {

                        createAccount(name.text, email.text, password.text)
                            .then((user) {
                          if (user != null) {

                            print("login done");
                            Navigator.push(context, MaterialPageRoute(builder:(_) => const HomeScreen()) );
                          } else {
                            print("login failed");
                          }
                        });
                      }
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login",
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
