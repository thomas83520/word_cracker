import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:humanize_duration/humanize_duration.dart';
import 'package:word_cracker/blocs/game_settings/game_settings_bloc.dart';
import 'package:word_cracker/components/setting_title.dart';
import 'package:word_cracker/tool/constants.dart';
import 'package:word_cracker/tool/string_extensions.dart';

class GameSettings extends StatelessWidget {
  const GameSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Text(
                  'Paramètres',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SettingTitle(text: 'Temps de la partie :'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.read<GameSettingsBloc>().add(RemoveTime());
                      },
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                    ),
                    Expanded(
                        child: BlocBuilder<GameSettingsBloc, GameSettingsState>(
                      builder: (context, state) {
                        return Text(
                          humanizeDuration(Duration(seconds: state.timer)),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        );
                      },
                    )),
                    IconButton(
                      onPressed: () {
                        context.read<GameSettingsBloc>().add(AddTime());
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SettingTitle(text: 'Catégorie :'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: BlocBuilder<GameSettingsBloc, GameSettingsStateSealed>(
                  builder: (context, state) {
                    return DropdownButton(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      isExpanded: true,
                      value: state.category,
                      onChanged: (value) {
                        context
                            .read<GameSettingsBloc>()
                            .add(ChangeCategory(value: value!));
                      },
                      dropdownColor: Colors.grey[800],
                      items: wordTheme
                          .map(
                            (theme) => DropdownMenuItem<int>(
                              value: theme['value'] as int,
                              child: Text(
                                theme['label'].toString().capitalize(),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/game/play');
                  },
                  child: const Text(
                    'Commencer',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ].reversed.toList(),
      ),
    );
  }
}
