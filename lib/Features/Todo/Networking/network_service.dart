import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_todo/Features/Todo/Model/api_response.dart';
// ignore: file_names

enum ApiError {
  NotFound,
  BadRequest,
  ServerError,
  UnknownError,
}

extension ApiErrorExtension on ApiError {
  String get message {
    switch (this) {
      case ApiError.NotFound:
        return "Not Found";
      case ApiError.BadRequest:
        return "Bad Request";
      case ApiError.ServerError:
        return "Server Error";
      case ApiError.UnknownError:
      default:
        return "Unknown Error";
    }
  }
}

mixin NetworkServiceMixin {
  Stream<ApiResponse<Map<String, dynamic>>> get(String url) async* {
    try {
      final response = await http.get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          yield ApiResponse.success(jsonDecode(response.body));
          break;
        case 400:
          yield ApiResponse.failure(ApiError.BadRequest);
          break;
        case 404:
          yield ApiResponse.failure(ApiError.NotFound);
          break;
        case 500:
          yield ApiResponse.failure(ApiError.ServerError);
          break;
        default:
          yield ApiResponse.failure(ApiError.UnknownError);
          break;
      }
    } catch (_) {
      yield ApiResponse.failure(ApiError.UnknownError);
    }
  }
}

class NetworkService with NetworkServiceMixin {
  Stream<ApiResponse<Map<String, dynamic>>> fetchData(String url) {
    return get(url);
  }
}