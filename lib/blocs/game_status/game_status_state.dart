part of 'game_status_bloc.dart';

sealed class GameStatusState extends Equatable {
  const GameStatusState({
    required this.currentWord,
    required this.nextWords,
    required this.correctWords,
    required this.wrongWords,
  });

  final String currentWord;
  final List<String> nextWords;
  final List<String> correctWords;
  final List<String> wrongWords;

  @override
  List<Object> get props => [currentWord, nextWords, correctWords, wrongWords];
}

final class GameInProgress extends GameStatusState {
  const GameInProgress({
    required super.currentWord,
    required super.nextWords,
    required super.correctWords,
    required super.wrongWords,
  });
}

final class GameCompleted extends GameStatusState {
  const GameCompleted({
    required super.currentWord,
    required super.nextWords,
    required super.correctWords,
    required super.wrongWords,
  });
}

final class GameError extends GameStatusState {
  GameError()
      : super(
          currentWord: '',
          nextWords: [],
          correctWords: [],
          wrongWords: [],
        );
}
