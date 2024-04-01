import 'package:flutter/material.dart';

class OldTodoTile extends StatelessWidget {
  final String title;
  final VoidCallback? onRemovePressed;

  const OldTodoTile({
    Key? key,
    required this.title,
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
          style: const TextStyle(),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onRemovePressed,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
