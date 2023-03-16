import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_api/todo.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Todo> todos = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    simpleTodo();
    getTodos();
  }

  getTodos() async {
    try {
      var response = await http.get(
          Uri.parse("https://6087dddba6f4a30017425143.mockapi.io/api/todos"));
      setState(() {
        todos = Todo.fromJsonList(jsonDecode(response.body) as List<dynamic>);
      });
    } catch (e) {}
  }

  Future<List<TodoApi>> simpleTodo() async {
    List<TodoApi> todosss = [];
    var response = await http.get(
        Uri.parse("https://6087dddba6f4a30017425143.mockapi.io/api/todos"));
    print(response.body);
    for (var i in jsonDecode(response.body)) {
      TodoApi todos = TodoApi.fromJson(i);
      todosss.add(todos);
    }

    return todosss;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(todos[index].title ?? 'Title'),
        ),
      ),
    );
  }
}

class TodoApi {
  String? title;
  String? description;
  String? category;
  int? timestamp;
  int? priority;
  String? userId;
  bool? isCompleted;
  String? id;

  TodoApi(
      {this.title,
      this.description,
      this.category,
      this.timestamp,
      this.priority,
      this.userId,
      this.isCompleted,
      this.id});

  TodoApi.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    category = json['category'];
    timestamp = json['timestamp'];
    priority = json['priority'];
    userId = json['user_id'];
    isCompleted = json['isCompleted'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['timestamp'] = this.timestamp;
    data['priority'] = this.priority;
    data['user_id'] = this.userId;
    data['isCompleted'] = this.isCompleted;
    data['id'] = this.id;
    return data;
  }
}
