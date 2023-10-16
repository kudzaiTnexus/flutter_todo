import 'package:flutter/material.dart';
import 'package:flutter_todo/Features/Todo/View/card.dart';
import 'package:flutter_todo/Features/Todo/Model/todo.dart';
import 'package:flutter_todo/Features/Todo/ViewModel/todoListViewModel.dart';
import 'package:flutter_todo/Features/Todo/DependencyInjection/setup_locator.dart';
// ignore_for_file: file_names, library_private_types_in_public_api


class TodoGridScreen extends StatefulWidget {
  @override
  _TodoGridScreenState createState() => _TodoGridScreenState();
}

class _TodoGridScreenState extends State<TodoGridScreen> {
  final TodoListViewModel _viewModel = getIt<TodoListViewModel>();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchTodos(); // Fetch todos when the screen is initialized
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Todos Grid')),
    body: StreamBuilder<List<Todo>>(
      stream: _viewModel.todosStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final todos = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Horizontal padding for the grid
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoCard(text: todos[index].todo);
            },
          ),
        );
      },
    ),
  );
}


  @override
  void dispose() {
    _viewModel.dispose(); // Dispose the viewModel when the screen is disposed
    super.dispose();
  }
}

