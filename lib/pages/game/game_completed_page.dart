import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cracker/blocs/game_status/game_status_bloc.dart';

class GameCompletedPage extends StatelessWidget {
  const GameCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStatusBloc, GameStatusState>(
      builder: (context, state) {
        return Column(
          children: [
            const Text(
              'Fin de la partie',
              style:
                  TextStyle(fontSize: 30, decoration: TextDecoration.underline),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              state.correctWords.length.toString(),
              style: GoogleFonts.fasthand(
                fontSize: 100,
              ),
            ),
            const Text(
              'Mots trouvés',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children:
                      state.correctWords.map((word) => Text(word)).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.go('/game'),
                child: const Text(
                  'Nouvelle partie',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
