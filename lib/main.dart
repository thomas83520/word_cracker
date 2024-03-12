import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:word_cracker/pages/game/game_page.dart';
import 'package:word_cracker/pages/game/game_settings.dart';
import 'package:word_cracker/pages/home_page.dart';
import 'package:word_cracker/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
        routes: [
          ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return Scaffold(
                body: child,
              );
            },
            routes: [
              GoRoute(
                path: 'game',
                builder: (context, state) => const GameSettings(),
                routes: [
                  GoRoute(
                    path: 'play',
                    builder: (context, state) => const GamePage(),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Word Cracker',
      theme: theme,
      routerConfig: router,
    );
  }
}
