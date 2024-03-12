import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:word_cracker/tool/constants.dart';
import 'package:word_cracker/tool/string_extensions.dart';

class GameSettings extends StatelessWidget {
  const GameSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Stack(
            children: [
              Positioned(
                child: TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 12,
                      ),
                      Text(
                        'Retour',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const Text(
                    'Paramètres',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownButton(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      isExpanded: true,
                      value: 0,
                      onChanged: (value) {},
                      dropdownColor: Colors.grey[800],
                      items: wordTheme
                          .map(
                            (theme) => DropdownMenuItem(
                              value: theme['value'],
                              child: Text(
                                theme['label'].toString().capitalize(),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Expanded(child: Container()),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/game/play');
                      },
                      child: const Text(
                        'Commencer',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
