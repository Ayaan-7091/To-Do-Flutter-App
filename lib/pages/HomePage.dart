import 'package:flutter/material.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/todoDialogBox.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../util/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
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
    db.updateDataBase();
    db.loadData();
  }

  void deleteFunction(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
    db.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        backgroundColor: Colors.yellow[600],
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) => todoTile(
          taskName: db.toDoList[index][0],
          taskCompleted: db.toDoList[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteTask: (context) => deleteFunction(index),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: createTask,
        backgroundColor: Colors.orange,
      ),
    );
  }
}
