import 'stub.dart';
import 'mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/Features/Todo/Model/todo.dart';
import 'package:flutter_todo/Features/Todo/Model/api_response.dart';
import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
import 'package:flutter_todo/Features/Todo/Networking/todoListService.dart';
import 'package:flutter_todo/Features/Todo/ViewModel/todoListViewModel.dart';
import 'package:flutter_todo/Features/Todo/DependencyInjection/setup_locator.dart';

void main() {
  group('TodoListViewModel', () {
    late TodoListViewModel viewModel;
    late MockTodoListService mockTodoListService;

    setUp(() {
      mockTodoListService = MockTodoListService();
      getIt.registerLazySingleton<TodoListService>(() => mockTodoListService);
      viewModel = TodoListViewModel();
    });

    test('emits list of Todo when fetch is successful', () async {
      when(mockTodoListService.fetchTodosData())
          .thenAnswer((_) => Stream.value(ApiResponse.success(stubTodoModelJson)));
      
      viewModel.fetchTodos();
      expect(await viewModel.todosStream!.first, isA<List<Todo>>());
    });

    test('emits error when fetch fails', () async {
      when(mockTodoListService.fetchTodosData())
          .thenAnswer((_) => Stream.value(ApiResponse.failure(ApiError.UnknownError)));
      
      viewModel.fetchTodos();
      await expectLater(viewModel.todosStream, emitsError(isA<ApiError>()));
    });

test('emits error when exception occurs during fetch', () async {
  when(mockTodoListService.fetchTodosData())
      .thenAnswer((_) => Stream<ApiResponse<Map<String, dynamic>>>.error(Exception('Some error')));
  
  viewModel.fetchTodos();
  await expectLater(viewModel.todosStream, emitsError(isA<Exception>()));
});

    test('dispose closes the todosStream', () {
      viewModel.dispose();
      expect(viewModel.todosStream, emitsDone);
    });

    test('fetchTodos triggers fetchData of TodoListService', () {
      viewModel.fetchTodos();
      verify(mockTodoListService.fetchTodosData()).called(1);
    });

    tearDown(() {
      getIt.unregister<TodoListService>();
    });
  });
}
