// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPressed;
  final Color color;

 MyButton({super.key,
 required this.buttonText,
   required this.onPressed,
   required this .color
 });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(buttonText),

    );
  }
}
