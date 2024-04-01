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
      child: Text(buttonText),
      color: color,

    );
  }
}
