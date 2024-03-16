part of 'game_settings_bloc.dart';

@immutable
sealed class GameSettingsEvent {}

class ChangeCategory implements GameSettingsEvent {
  ChangeCategory({required this.value});

  final int value;
}

class AddTime implements GameSettingsEvent {
  AddTime();
}

class RemoveTime implements GameSettingsEvent {
  RemoveTime();
}
