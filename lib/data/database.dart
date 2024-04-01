import  'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference to box
final myBox = Hive.box('mybox');

//run this method if this is the first time opening of the app

void createInitialData(){
  toDoList = [
    ["+ button to add new tasks",false],
    ["Click check on task completion",true],

  ];
}
  //load data from database
void loadData(){
  toDoList = myBox.get("TODOLIST");
}

void updateDataBase(){
  myBox.put("TODOLIST",toDoList);
}
}