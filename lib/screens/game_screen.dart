import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:word_cracker/blocs/game_status/game_status_bloc.dart';
import 'package:word_cracker/blocs/game_timer.dart/game_timer_bloc.dart';
import 'package:word_cracker/components/game_current_word.dart';
import 'package:word_cracker/components/game_timer.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text(
              'Quitter',
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
        const GameTimer(),
        const Spacer(flex: 1),
        const GameCurrentWord(),
        const Spacer(flex: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<GameTimerBloc, GameTimerState>(
            builder: (context, timerState) {
              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: timerState is! GameTimerInProgress
                            ? null
                            : () => context
                                .read<GameStatusBloc>()
                                .add(const WrongWord()),
                        child: const Text(
                          'Passe',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: timerState is! GameTimerInProgress
                            ? null
                            : () {
                                context
                                    .read<GameStatusBloc>()
                                    .add(const CorrectWord());
                              },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green)),
                        child: const Text(
                          'Trouvé',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
