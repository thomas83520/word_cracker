import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_cracker/blocs/game_timer.dart/game_timer_bloc.dart';

const bgColor = Color.fromRGBO(238, 217, 196, 1);

class GameTimerActions extends StatelessWidget {
  const GameTimerActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameTimerBloc, GameTimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              GameTimerInitial() => [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        bgColor,
                      ),
                    ),
                    child: const Text(
                      'Lancer la partie',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () => context
                        .read<GameTimerBloc>()
                        .add(TimerStarted(duration: state.duration)),
                  ),
                ],
              GameTimerInProgress() => [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        bgColor,
                      ),
                    ),
                    child: const Text(
                      'Pause',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () =>
                        context.read<GameTimerBloc>().add(const TimerPaused()),
                  ),
                ],
              GameTimerPaused() => [
                  ElevatedButton(
                    onPressed: () => context.read<GameTimerBloc>().add(
                          const TimerResumed(),
                        ),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        bgColor,
                      ),
                    ),
                    child: const Text(
                      'Reprendre',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              GameTimerCompleted() => []
            }
          ],
        );
      },
    );
  }
}
