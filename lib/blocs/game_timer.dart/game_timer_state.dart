part of 'game_timer_bloc.dart';

sealed class GameTimerState extends Equatable {
  const GameTimerState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration];
}

final class GameTimerInitial extends GameTimerState {
  const GameTimerInitial(super.duration);
}

final class GameTimerInProgress extends GameTimerState {
  const GameTimerInProgress(super.duration);
}

final class GameTimerPaused extends GameTimerState {
  const GameTimerPaused(super.duration);
}

final class GameTimerCompleted extends GameTimerState {
  const GameTimerCompleted() : super(0);
}
