import 'package:flutter/material.dart';

import 'myButton.dart';

class TodoDialogBox extends StatelessWidget {

final controller;
VoidCallback onSave;
VoidCallback onCancel;


TodoDialogBox({super.key,
  required this.controller,
  required this.onSave,
  required this.onCancel,
});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
backgroundColor: Colors.yellow[600],
      content: Container(
        height: 150,
      width: 300,

      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //to take user input
          TextField(
            controller: controller,
          decoration: InputDecoration(border: OutlineInputBorder(),
          hintText: "Add a new Task",fillColor: Colors.white,hoverColor: Colors.white),

          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children :[

          //button => save & cancel
          MyButton(buttonText: "save",onPressed: onSave,color: Colors.yellow,),

          const SizedBox(width: 8,),
          //cancel button
          MyButton(buttonText: "cancel", onPressed: onCancel, color: Colors.yellow)
         ] )
        ],
      ),
      ),
    );
  }
}
