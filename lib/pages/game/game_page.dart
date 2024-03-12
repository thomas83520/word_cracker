import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Back'),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}
