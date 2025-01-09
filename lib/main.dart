import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/core/di/service_locator.dart';
import 'package:hastools/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:hastools/features/todos/presentation/screens/detail_todo_screen.dart';
import 'package:hastools/features/todos/presentation/screens/todo_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  setupServiceLocator();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => getIt<TodoBloc>()..add(FetchTodos()),
          child: TodoScreen(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return DetailTodoScreen();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}
