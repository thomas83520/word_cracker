import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_cracker/components/rotating_triangle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              const Positioned(
                bottom: -50,
                child: RotatingTriangle(),
              ),
              Positioned(
                bottom: height * 0.8,
                child: Text(
                  'Word Cracker',
                  style: GoogleFonts.kodeMono(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              Positioned(
                bottom: height * 0.5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 25,
                    ),
                    elevation: 4,
                    shadowColor: Colors.red,
                  ),
                  onPressed: () {
                    context.go('/game');
                  },
                  child: const Text(
                    'Nouvelle Partie',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
