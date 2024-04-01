import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class todoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)?onChanged;
  Function (BuildContext)?deleteTask;

  todoTile({super.key,
    required this.taskName,
    required this.taskCompleted,
  required this.onChanged,
  required this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25,right: 25,top: 20),
        child : Slidable(
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(onPressed: deleteTask,
                          icon: Icons.delete_forever,
                            backgroundColor: Colors.redAccent,
                             borderRadius: BorderRadius.circular(12),
                        ),

                  ],
                ),

            child:Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.yellow[600],
            borderRadius: BorderRadius.circular(8)
          ),
          child:Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged,activeColor: Colors.orange,),
              Text(taskName,
              style: TextStyle( decoration: taskCompleted? TextDecoration.lineThrough :  TextDecoration.none ),
              ),

            ],
          )
    )));
  }
}
