import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/components/app_scaffold.dart';
import 'package:hastools/core/di/service_locator.dart';
import 'package:hastools/features/home/presentation/home_screen.dart';
import 'package:hastools/features/profile/presentation/profile_screen.dart';
import 'package:hastools/features/todos/presentation/screens/detail_todo_screen.dart';
import 'package:hastools/features/tool/presentation/bloc/tool_bloc.dart';
import 'package:hastools/features/tool/presentation/screens/calculator_screen.dart';
import 'package:hastools/features/tool/presentation/screens/currency_converter_screen.dart';
import 'package:hastools/features/tool/presentation/screens/keystore_screen.dart';
import 'package:hastools/features/tool/presentation/screens/tools_screen.dart';

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

final GoRouter appRouter = GoRouter(
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
                  create: (context) => getIt<ToolBloc>()..add(LoadTools()),
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
                  create: (context) => getIt<ToolBloc>()..add(LoadTools()),
                  child: const ToolsScreen(),
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
                return BlocProvider(
                  create: (context) => getIt<ToolBloc>()..add(LoadTools()),
                  child: const ProfileScreen(),
                );
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
    GoRoute(
        path: '/tools',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => getIt<ToolBloc>()..add(LoadTools()),
            child: const ToolsScreen(),
          );
        },
        routes: [
          GoRoute(
            path: '/calculator',
            builder: (BuildContext context, GoRouterState state) {
              return const CalculatorScreen();
            },
          ),
          GoRoute(
            path: '/currency-converter',
            builder: (BuildContext context, GoRouterState state) {
              return const CurrencyConverterScreen();
            },
          ),
          GoRoute(
            path: '/crypto-tools',
            builder: (BuildContext context, GoRouterState state) {
              return const CurrencyConverterScreen();
            },
          ),
          GoRoute(
            path: '/keystore',
            builder: (BuildContext context, GoRouterState state) {
              return KeystoreScreen();
            },
          ),
        ]),
  ],
);
