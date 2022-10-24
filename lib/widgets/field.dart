import 'package:flutter/material.dart';

Widget field(Size size, String hintText, IconData icon,
    TextEditingController controller) {
  return SizedBox(
    height: size.height / 14,
    width: size.width / 1.1,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
  );
}
