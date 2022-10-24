import 'package:flutter/material.dart';

Widget customButton(Size size, String text) {
  return Container(
    height: size.height / 14,
    width: size.width / 5,
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 22,
        ),
      ),
    ),
  );
}
