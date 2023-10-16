import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
// ignore: file_names


class ApiResponse<T> {
  final T? data;
  final ApiError? error;

  ApiResponse.success(this.data) : error = null;
  ApiResponse.failure(this.error) : data = null;

  bool get isSuccess => error == null;
}
