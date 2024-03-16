import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cracker/blocs/game_status/game_status_bloc.dart';
import 'package:word_cracker/blocs/game_timer.dart/game_timer_bloc.dart';

class GameCurrentWord extends StatelessWidget {
  const GameCurrentWord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameTimerBloc, GameTimerState>(
      builder: (context, state) {
        var isPaused = false;
        if (state is! GameTimerInProgress) {
          isPaused = true;
        }
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width - 30,
          child: FittedBox(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: isPaused ? 2.5 : 0,
                sigmaY: isPaused ? 2.5 : 0,
              ),
              child: BlocBuilder<GameStatusBloc, GameStatusState>(
                builder: (context, state) {
                  return Text(
                    state.currentWord,
                    style: GoogleFonts.sourceCodePro(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
