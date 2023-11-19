import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../features/main_screen.dart';
import '../../features/news/bloc/news_bloc.dart';
import '../../features/news/news_screen.dart';

/// Navigator key for all routes depending on parent navigator level
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// export rootNavigatorKey for using in other file
final rootNavigationKey = _rootNavigatorKey;

/// Navigator key for bottom navigation bar routes
final _mainScreenNavigationKey = GlobalKey<NavigatorState>();

/// Screen paths for all app routes
class ScreenPaths {
  static String home = '/';
  static String chat = '/chat';
  static String setting = '/setting';
}

/// Main app routes using Go Router package
/// which contains the bottom navigation bar routes
/// and also all app routes working with path
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: ScreenPaths.home,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state,
          StatefulNavigationShell navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.home,
              path: '/',
              builder: (context, state) => BlocProvider<NewsBloc>(
                create: (context) => GetIt.I.get<NewsBloc>()..add(const NewsFecthData()),
                child: const NewsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.chat,
              path: '/chat',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('Chat'),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: ScreenPaths.setting,
              path: '/setting',
              builder: (context, state) => const Scaffold(
                body: Center(
                  child: Text('Setting'),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
