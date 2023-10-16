import 'stub.dart';
import 'mocks.dart';  
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/Features/Todo/Model/api_response.dart';
import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
import 'package:flutter_todo/Features/Todo/Networking/todoListService.dart';
import 'package:flutter_todo/Features/Todo/DependencyInjection/setup_locator.dart';

void main() {
  group('TodoListService', () {
    late TodoListService service;
    late MockNetworkService mockNetworkService;

    setUp(() {
      mockNetworkService = MockNetworkService();
      getIt.registerLazySingleton<NetworkService>(() => mockNetworkService);
      service = TodoListService();
    });

test('fetchTodosData calls NetworkService fetchData with correct URL', () {
  // Arrange
  when(mockNetworkService.fetchData('https://dummyjson.com/todos'))
    .thenAnswer((_) => Stream.value(ApiResponse.success(stubTodoModelJson)));  // Use stub data

  // Act
  service.fetchTodosData();

  // Assert
  verify(mockNetworkService.fetchData('https://dummyjson.com/todos')).called(1);
});

    test('fetchTodosData emits successful ApiResponse when API call is successful', () async {
      // Arrange
      when(mockNetworkService.fetchData('https://dummyjson.com/todos'))
        .thenAnswer((_) => Stream.value(ApiResponse.success(stubTodoModelJson)));  // Use stub data

      // Act
      final result = await service.fetchTodosData().first;

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, stubTodoModelJson);  // Use stub data
    });

    test('fetchTodosData emits error ApiResponse when API call fails', () async {
      // Arrange
      when(mockNetworkService.fetchData('https://dummyjson.com/todos'))
        .thenAnswer((_) => Stream.value(ApiResponse.failure(ApiError.ServerError)));

      // Act
      final result = await service.fetchTodosData().first;

      // Assert
      expect(result.isSuccess, false);
      expect(result.error?.message, 'Server Error');
    });

test('fetchTodosData emits error ApiResponse when exception occurs', () async {
  // Arrange
  when(mockNetworkService.fetchData('https://dummyjson.com/todos'))
    .thenAnswer((_) => Stream.value(ApiResponse.failure(ApiError.UnknownError)));

  // Act
  final result = await service.fetchTodosData().first;

  // Assert
  expect(result.isSuccess, false);
  expect(result.error, ApiError.UnknownError);
});

    tearDown(() {
      getIt.unregister<NetworkService>();
    });
  });
}
