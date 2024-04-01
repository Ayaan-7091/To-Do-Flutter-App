import 'dart:math';
import 'package:flutter/material.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/new_todo.dart';
import 'package:to_do/util/todoDialogBox.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'completed_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  List<List<dynamic>> completedTasks = [];

  @override
  void initState() {
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  final TextEditingController controller = TextEditingController();

  void checkBoxChanged(bool newValue, int index) {
    setState(() {
      if (newValue) {
        completedTasks.add(db.toDoList[index]);
        db.toDoList.removeAt(index);
      } else {
        db.toDoList.add(completedTasks[index]);
        completedTasks.removeAt(index);
      }
    });
    db.loadData();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return TodoDialogBox(
          controller: controller,
          onSave: saveTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void saveTask() {
    setState(() {
      db.toDoList.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    db.loadData();
  }

  void deleteFunction(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.loadData();
  }

  void navigateToCompletedTasksPage() async {
    final result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CompletedTasksPage(completedTasks: completedTasks),
    ));

    // Update completedTasks if tasks were deleted
    if (result != null && result is List<List<dynamic>>) {
      setState(() {
        completedTasks = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        backgroundColor: Colors.yellow[600],
        actions: [
          IconButton(
            onPressed: navigateToCompletedTasksPage,
            icon: const Icon(Icons.done),
            tooltip: 'Completed Tasks',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
        child: db.toDoList.isEmpty
            ? const Text(
                'Add your tasks',
                style: TextStyle(fontSize: 20),
              )
            : ListView.builder(
                itemCount: min(1, db.toDoList.length),
                itemBuilder: (context, index) => TodoTile(
                  title: db.toDoList[index][0],
                  isCompleted: db.toDoList[index][1],
                  onCompletePressed: (bool newValue) =>
                      checkBoxChanged(newValue, index),
                  onRemovePressed: () => deleteFunction(index),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createTask,
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
