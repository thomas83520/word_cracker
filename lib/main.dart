import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:word_cracker/blocs/game_settings/game_settings_bloc.dart';
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
        builder: (context, state) => const HomePage(
          key: ValueKey('homePage'),
        ),
        routes: [
          ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return BlocProvider(
                create: (context) => GameSettingsBloc(),
                child: Scaffold(
                    body: SafeArea(
                        child: DefaultTextStyle(
                            style: const TextStyle(color: Colors.white),
                            child: child))),
              );
            },
            routes: [
              GoRoute(
                path: 'game',
                builder: (context, state) => const GameSettings(
                  key: ValueKey('gameSettings'),
                ),
                routes: [
                  GoRoute(
                    path: 'play',
                    builder: (context, state) => const GamePage(
                      key: ValueKey('gamePage'),
                    ),
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
