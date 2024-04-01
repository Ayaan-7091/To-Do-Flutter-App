import 'package:flutter/material.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/util/todoDialogBox.dart';
import  'package:hive_flutter/hive_flutter.dart';


import '../util/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refrence to the box
  final myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // TODO: implement initState
    if(myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      //there already exist data
      db.loadData();
    }
    super.initState();
  }

  final TextEditingController controller = TextEditingController();
  //list for todos

  //function to control checkbox state
  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];

    });
    db.loadData();

  }
  
  //function to create todo
  void createTask(){
    showDialog(context: context,
        builder: (context){
      return TodoDialogBox(controller: controller,
        onSave:saveTask,
        onCancel:()=> Navigator.of(context).pop(),
      );
        });
  }

  //function to save task
  void saveTask(){
    setState(() {
      db.toDoList.add([controller.text,false]);
      controller.clear();

    });
    Navigator.of(context).pop();
    db.loadData();

  }

  //function to delete task
  void deleteFunction(int index){
    setState(() {
      db.toDoList.removeAt(index);

    });
    db.loadData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        backgroundColor: Colors.yellow[600],
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context,index)=>todoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value)=> checkBoxChanged(value,index),
            deleteTask: (context)=>deleteFunction(index),
          )
      ),
      floatingActionButton:FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: createTask,
        backgroundColor: Colors.orange,
      ),

    );
  }
}
