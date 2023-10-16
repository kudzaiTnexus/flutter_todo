import 'dart:async';
import 'package:flutter_todo/Features/Todo/Model/todo.dart';
import 'package:flutter_todo/Features/Todo/Model/todoModel.dart';
import 'package:flutter_todo/Features/Todo/Networking/todoListService.dart';
import 'package:flutter_todo/Features/Todo/DependencyInjection/setup_locator.dart';


mixin TodoListViewModelMixin {
  Stream<List<Todo>>? get todosStream;
  fetchTodos();
  dispose();
}

class TodoListViewModel with TodoListViewModelMixin {
  final TodoListService _todoListService = getIt<TodoListService>();

  final _todosController = StreamController<List<Todo>>();

  @override
  Stream<List<Todo>>? get todosStream => _todosController.stream;

  @override
  fetchTodos() {
    _todoListService.fetchTodosData().listen(
      (response) {
        if (response.isSuccess) {
          _todosController.add(TodoModel.fromJson(response.data!).todos);
        } else {
          if (response.error != null) {
            _todosController.addError(response.error!);
          } 
        }
      },
      onError: (error) {
        _todosController.addError(error);
      },
    );
  }

  @override
  dispose() {
    _todosController.close();
  }
}

