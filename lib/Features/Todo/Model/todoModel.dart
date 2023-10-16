import 'package:flutter_todo/Features/Todo/Model/todo.dart';
// ignore: file_names

class TodoModel {
    List<Todo> todos;
    int total;
    int skip;
    int limit;

    TodoModel({
        required this.todos,
        required this.total,
        required this.skip,
        required this.limit,
    });

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel (
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
    };
}
