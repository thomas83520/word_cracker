part of 'game_timer_bloc.dart';

sealed class GameTimerEvent extends Equatable {
  const GameTimerEvent();

  @override
  List<Object> get props => [];
}

final class TimerStarted extends GameTimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

final class TimerPaused extends GameTimerEvent {
  const TimerPaused();
}

final class TimerResumed extends GameTimerEvent {
  const TimerResumed();
}

class _TimerTicked extends GameTimerEvent {
  const _TimerTicked({required this.duration});
  final int duration;
}
