import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Account created");
      await firestore.collection("users").doc(auth.currentUser?.uid).set({
        "name" : name,
        "email" : email,
        "status" : "Unavailable"
      });
      return user;
    } else {
      print("not created");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("logged in");
      return user;
    } else {
      print("not ");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  try {
    await auth.signOut().then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}
