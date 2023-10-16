import 'package:flutter_todo/Features/Todo/Model/api_response.dart';
import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
import 'package:flutter_todo/Features/Todo/DependencyInjection/setup_locator.dart';
// ignore: file_names

mixin TodoListServiceMixin {
  Stream<ApiResponse<Map<String, dynamic>>> fetchTodosData();
}

class TodoListService with TodoListServiceMixin {
  final NetworkService _apiService = getIt<NetworkService>();

@override
Stream<ApiResponse<Map<String, dynamic>>> fetchTodosData() {
  return _apiService.fetchData('https://dummyjson.com/todos').handleError((error) {
    // Handle the error and return a failed ApiResponse
    return ApiResponse.failure(ApiError.UnknownError); // Assuming you have this setup for your ApiResponse
  });
}

}
