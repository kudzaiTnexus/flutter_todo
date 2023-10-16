import 'package:get_it/get_it.dart';
import 'package:flutter_todo/Features/Todo/Networking/todoListService.dart';
import 'package:flutter_todo/Features/Todo/Networking/network_service.dart';
import 'package:flutter_todo/Features/Todo/ViewModel/todoListViewModel.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<NetworkService>(() => NetworkService());

  getIt.registerFactory<TodoListService>(() => TodoListService());
  getIt.registerFactory<TodoListViewModel>(() => TodoListViewModel());
}
