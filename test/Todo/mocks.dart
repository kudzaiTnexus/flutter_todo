import 'stub.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_todo/Features/Todo/Model/todo.dart';
import 'package:flutter_todo/Features/Todo/Model/api_response.dart';
import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
import 'package:flutter_todo/Features/Todo/Networking/todoListService.dart';
import 'package:flutter_todo/Features/Todo/ViewModel/todoListViewModel.dart';

class MockTodoListViewModel extends Mock implements TodoListViewModel {
  // Mock the todosStream to return stubTodoData
  @override
  Stream<List<Todo>> get todosStream {
    final todos = List<Todo>.from(stubTodoModelJson['todos'].map((x) => Todo.fromJson(x)));
    return Stream.value(todos);
  }
}

class MockNetworkService extends Mock implements NetworkService {

  // Overriding the fetchData method to return a stubbed response
  @override
  Stream<ApiResponse<Map<String, dynamic>>> fetchData(String url) {
    return super.noSuchMethod(
      Invocation.method(#fetchData, [url]),
      returnValue: Stream.value(ApiResponse.success(stubTodoModelJson)),  // Use stub data
      returnValueForMissingStub: Stream.value(ApiResponse.success(stubTodoModelJson))
    );
  }
}

class MockTodoListService extends Mock implements TodoListService {

  // Overriding the fetchTodosData method to return a stubbed response
  @override
  Stream<ApiResponse<Map<String, dynamic>>> fetchTodosData() {
    return super.noSuchMethod(
      Invocation.method(#fetchTodosData, []),
      returnValue: Stream.value(ApiResponse.success(stubTodoModelJson)),  // Use stub data
      returnValueForMissingStub: Stream.value(ApiResponse.success(stubTodoModelJson))
    );
  }
}
