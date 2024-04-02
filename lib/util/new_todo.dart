import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool)? onCompletePressed;
  final VoidCallback? onRemovePressed;
  final double opacity; // Add opacity parameter

  const TodoTile({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onCompletePressed,
    required this.onRemovePressed,
    required this.opacity, // Accept opacity as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      // Wrap with Opacity widget
      opacity: opacity, // Set opacity
      child: Container(
        height: 70,
        // Wrap with Container to apply opacity
        decoration: BoxDecoration(
          color: Colors.yellow[600],
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.check),
                onPressed: () {
                  if (onCompletePressed != null) onCompletePressed!(true);
                },
                color: Colors.green,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onRemovePressed,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
