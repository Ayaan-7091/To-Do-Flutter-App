import 'package:flutter/material.dart';
import 'package:to_do/util/todoTile.dart';

class CompletedTasksPage extends StatefulWidget {
  final List<List<dynamic>> completedTasks;
  // final Function(List<List<dynamic>>) updateTasks;

  const CompletedTasksPage({
    Key? key,
    required this.completedTasks,
  }) : super(key: key);

  @override
  State<CompletedTasksPage> createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  List<List<dynamic>> _completedTasks = [];

  @override
  void initState() {
    _completedTasks = List.from(widget.completedTasks);
    super.initState();
  }

  void removeTask(int index) {
    setState(() {
      _completedTasks.removeAt(index);
    });

    // Pass back the updated completedTasks list when task is deleted
    Navigator.of(context).pop(_completedTasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('Completed Tasks'),
        backgroundColor: Colors.yellow[600],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.separated(
          itemCount: _completedTasks.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10), // Add gap between items
          itemBuilder: (context, index) {
            return OldTodoTile(
              title: _completedTasks[index][0],
              onRemovePressed: () {
                // Call the removeTask function to remove the task from the list
                removeTask(index);
              },
            );
          },
        ),
      ),
    );
  }
}
