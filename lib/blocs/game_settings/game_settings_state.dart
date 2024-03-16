part of 'game_settings_bloc.dart';

@immutable
sealed class GameSettingsStateSealed extends Equatable {
  const GameSettingsStateSealed(this.timer, this.category);

  final int timer;
  final int category;

  @override
  List<Object?> get props => [timer, category];
}

final class GameSettingsState extends GameSettingsStateSealed {
  const GameSettingsState(super.timer, super.category);
}
