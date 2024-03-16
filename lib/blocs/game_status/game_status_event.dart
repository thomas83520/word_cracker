part of 'game_status_bloc.dart';

sealed class GameStatusEvent extends Equatable {
  const GameStatusEvent();

  @override
  List<Object> get props => [];
}

final class InitGame extends GameStatusEvent {
  const InitGame();
}

final class LoadNextWord extends GameStatusEvent {
  const LoadNextWord(this.number);

  final int number;
}

final class CorrectWord extends GameStatusEvent {
  const CorrectWord();
}

final class WrongWord extends GameStatusEvent {
  const WrongWord();
}

final class GameIsOver extends GameStatusEvent {
  const GameIsOver();
}
