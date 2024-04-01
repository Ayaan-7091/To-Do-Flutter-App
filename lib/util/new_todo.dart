import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool)? onCompletePressed;
  final VoidCallback? onRemovePressed;

  const TodoTile({
    Key? key,
    required this.title,
    required this.isCompleted,
    required this.onCompletePressed,
    required this.onRemovePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              icon: Icon(Icons.check),
              onPressed: () {
                if (onCompletePressed != null) onCompletePressed!(true);
              },
              color: Colors.green,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onRemovePressed,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
