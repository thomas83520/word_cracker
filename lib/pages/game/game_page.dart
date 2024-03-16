import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:word_cracker/blocs/game_settings/game_settings_bloc.dart';
import 'package:word_cracker/blocs/game_status/game_status_bloc.dart';
import 'package:word_cracker/blocs/game_timer.dart/game_timer_bloc.dart';
import 'package:word_cracker/data/trouve_mots_provider.dart';
import 'package:word_cracker/domain/game_repository.dart';
import 'package:word_cracker/pages/game/game_completed_page.dart';
import 'package:word_cracker/screens/game_screen.dart';
import 'package:word_cracker/tool/ticker.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    final gameSettings = context.select((GameSettingsBloc bloc) => bloc.state);
    return RepositoryProvider(
      create: (context) =>
          GameRepository(trouveMotsProvider: TrouveMotsProvider()),
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GameTimerBloc(
                duration: gameSettings.timer,
                ticker: const Ticker(),
              ),
            ),
            BlocProvider(
              create: (context) => GameStatusBloc(
                gameRepository: RepositoryProvider.of<GameRepository>(context),
                categoryId: gameSettings.category,
              )..add(const InitGame()),
            ),
          ],
          child: BlocListener<GameTimerBloc, GameTimerState>(
            listener: (context, state) {
              if (state is GameTimerCompleted) {
                context.read<GameStatusBloc>().add(const GameIsOver());
              }
            },
            child: BlocBuilder<GameStatusBloc, GameStatusState>(
              buildWhen: (previous, current) =>
                  previous.runtimeType != current.runtimeType,
              builder: (context, state) {
                if (state is GameCompleted) {
                  return const GameCompletedPage();
                }
                return const GameScreen();
              },
            ),
          ),
        );
      }),
    );
  }
}
