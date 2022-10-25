import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/screens/home_screen.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';

class Authenticate extends StatelessWidget {
  Authenticate({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(auth.currentUser != null){
      return HomeScreen();
    }
    else{
      return LoginScreen();
    }
  }
}
