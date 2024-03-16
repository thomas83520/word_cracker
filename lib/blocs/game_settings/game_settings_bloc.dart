import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'game_settings_event.dart';
part 'game_settings_state.dart';

class GameSettingsBloc extends Bloc<GameSettingsEvent, GameSettingsState> {
  GameSettingsBloc() : super(const GameSettingsState(60, 0)) {
    on<ChangeCategory>(_changeCategory);
    on<AddTime>(_addTime);
    on<RemoveTime>(_removeTime);
  }

  void _changeCategory(ChangeCategory event, Emitter<GameSettingsState> emit) {
    emit(GameSettingsState(state.timer, event.value));
  }

  void _addTime(AddTime event, Emitter<GameSettingsState> emit) {
    emit(GameSettingsState(min(state.timer + 30, 300), state.category));
  }

  void _removeTime(RemoveTime event, Emitter<GameSettingsState> emit) {
    emit(GameSettingsState(max(state.timer - 30, 30), state.category));
  }
}
