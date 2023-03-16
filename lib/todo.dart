class Todo {
  String? title;
  int? timestamp;
  String? desc;
  String? category;
  int? priority;
  String? user_id;
  bool? isCompleted;
  String? id;

  Todo(
      {this.timestamp,
      this.title,
      this.desc,
      this.category,
      this.priority,
      this.user_id,
      this.isCompleted,
      this.id});
  static List<Todo> fromJsonList(List<dynamic> json) {
    List<Todo> todos = [];
    for (var jsonTodo in json) {
      var jsonTodoMap = jsonTodo as Map<String, dynamic>;
      todos.add(Todo(
        title: jsonTodoMap['title'],
        desc: jsonTodoMap["description"],
        category: jsonTodoMap["category"],
        priority: jsonTodoMap["priority"],
        user_id: jsonTodoMap["user_id"],
        isCompleted: jsonTodoMap["isCompleted"],
        id: jsonTodoMap["id"],
      ));
    }
    return todos;
  }
}
