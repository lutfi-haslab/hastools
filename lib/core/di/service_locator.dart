import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:hastools/core/constants/api_constants.dart';
import 'package:hastools/core/network/dio_client.dart';
import 'package:hastools/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:hastools/features/todos/presentation/bloc/todo_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton(() {
    final dio = Dio();
    dio.options.headers = {
      'Accept': '*/*',
      'apikey': ApiConstants.apiKey,
      'Authorization': ApiConstants.authToken,
    };
    return dio;
  });
  getIt.registerLazySingleton(() => DioClient(getIt<Dio>()));

  // Repositories
  getIt.registerLazySingleton(() => TodoRepository(dioClient: getIt<DioClient>()));

  // BLoCs
  getIt.registerFactory(() => TodoBloc(repository: getIt<TodoRepository>()));
}