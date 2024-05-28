import 'package:flutter/material.dart';
import 'package:myapp/utils/todo_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();
  List todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      List tasksJson = jsonDecode(tasksString);
      setState(() {
        todoList = tasksJson.map((task) => [task['name'], task['isComplete']]).toList();
      });
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> tasksJson = todoList.map((task) => {
      'name': task[0],
      'isComplete': task[1],
    }).toList();
    prefs.setString('tasks', jsonEncode(tasksJson));
  }

  void checkboxchange(int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
      _saveTasks();
    });
  }

  void saveNewTask() {
    setState(() {
      todoList.add([_controller.text, false]);
      _controller.clear();
      _saveTasks();
    });
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      appBar: AppBar(
        title: const Text("Mi Lista"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, index) {
          return ToDoList(
            taskName: todoList[index][0],
            taskComplete: todoList[index][1],
            onChanged: (value) => checkboxchange(index),
            deleteFuntion: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Nueva tarea",
                    filled: true,
                    fillColor: Colors.white30,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: saveNewTask,
            ),
          ],
        ),
      ),
    );
  }
}
