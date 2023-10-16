import 'package:flutter_todo/Features/Todo/Model/todo.dart';
import 'package:flutter_todo/Features/Todo/Model/todoModel.dart';
// stubs.dart


final Todo stubTodo = Todo(
  id: 1,
  todo: "Test Todo",
  completed: false,
  userId: 101,
);

final TodoModel stubTodoModel = TodoModel(
  todos: [stubTodo],
  total: 1,
  skip: 0,
  limit: 1,
);

final Map<String, dynamic> stubTodoJson = {
  "id": 1,
  "todo": "Test Todo",
  "completed": false,
  "userId": 101,
};

final Map<String, dynamic> stubTodoModelJson = {
  "todos": [stubTodoJson],
  "total": 1,
  "skip": 0,
  "limit": 1,
};
