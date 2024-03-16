import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_cracker/tool/ticker.dart';

part 'game_timer_event.dart';
part 'game_timer_state.dart';

class GameTimerBloc extends Bloc<GameTimerEvent, GameTimerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;

  GameTimerBloc({required int duration, required Ticker ticker})
      : _ticker = ticker,
        super(GameTimerInitial(duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<_TimerTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<GameTimerState> emit) {
    emit(GameTimerInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration)));
  }

  void _onPaused(TimerPaused event, Emitter<GameTimerState> emit) {
    if (state is GameTimerInProgress) {
      _tickerSubscription?.pause();
      emit(GameTimerPaused(state.duration));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<GameTimerState> emit) {
    if (state is GameTimerPaused) {
      _tickerSubscription?.resume();
      emit(GameTimerInProgress(state.duration));
    }
  }

  void _onTicked(_TimerTicked event, Emitter<GameTimerState> emit) {
    emit(
      event.duration > 0
          ? GameTimerInProgress(event.duration)
          : const GameTimerCompleted(),
    );
  }
}
