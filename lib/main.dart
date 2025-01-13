import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/di/service_locator.dart';
import 'package:hastools/features/home/presentation/home_screen.dart';
import 'package:hastools/features/profile/presentation/profile_screen.dart';
import 'package:hastools/features/todos/presentation/bloc/todo_bloc.dart';
import 'package:hastools/features/todos/presentation/screens/detail_todo_screen.dart';
import 'package:hastools/features/todos/presentation/screens/todo_screen.dart';

class ShellScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({
    required this.navigationShell,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      withBottomNavigation: true,
      currentIndex: navigationShell.currentIndex,
      onNavigate: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      child: navigationShell,
    );
  }
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  setupServiceLocator();
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) => getIt<TodoBloc>()..add(FetchTodos()),
                  child: const HomeScreen(),
                );
              },
              // routes: [
              //   GoRoute(
              //     path: 'todo',
              //     builder: (BuildContext context, GoRouterState state) {
              //       return BlocProvider(
              //         create: (context) => getIt<TodoBloc>()..add(FetchTodos()),
              //         child: TodoScreen(),
              //       );
              //     },
              //   ),
              // ],
            ),
          ],
        ),
        // Tools Branch
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/tools',
              builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                  create: (context) => getIt<TodoBloc>()..add(FetchTodos()),
                  child: TodoScreen(),
                );
              },
            ),
          ],
        ),
        // Profile Branch
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileScreen();
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/todo/details',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailTodoScreen();
      },
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
