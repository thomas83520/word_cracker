import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_cracker/domain/game_repository.dart';

part 'game_status_event.dart';
part 'game_status_state.dart';

class GameStatusBloc extends Bloc<GameStatusEvent, GameStatusState> {
  GameStatusBloc({
    required GameRepository gameRepository,
    required this.categoryId,
  })  : _gameRepository = gameRepository,
        super(
          const GameInProgress(
            currentWord: '',
            nextWords: [],
            correctWords: [],
            wrongWords: [],
          ),
        ) {
    on<InitGame>(_initGame);
    on<LoadNextWord>(_loadNextWord);
    on<CorrectWord>(_correctWord);
    on<WrongWord>(_wrongWord);
    on<GameIsOver>(_closeGame);
  }

  final int categoryId;

  final GameRepository _gameRepository;

  Future<void> _initGame(
    InitGame event,
    Emitter<GameStatusState> emit,
  ) async {
    final nextWords = await _getNextWord(6);

    final currentWord = nextWords[0];

    nextWords.removeAt(0);

    emit(
      GameInProgress(
        currentWord: currentWord,
        nextWords: nextWords,
        correctWords: const [],
        wrongWords: const [],
      ),
    );
  }

  Future<void> _loadNextWord(
    LoadNextWord event,
    Emitter<GameStatusState> emit,
  ) async {
    final nextWords = await _getNextWord(event.number);
    emit(
      GameInProgress(
        currentWord: state.currentWord,
        nextWords: [...state.nextWords, ...nextWords],
        correctWords: state.correctWords,
        wrongWords: state.correctWords,
      ),
    );
  }

  Future<List<String>> _getNextWord(int number) async {
    List<String> nextWords = [];
    if (categoryId == 0) {
      nextWords = await _gameRepository.getRandomWord(number);
    } else {
      nextWords = await _gameRepository.getWordFromCategory(categoryId, number);
    }

    return nextWords;
  }

  Future<void> _correctWord(
    CorrectWord event,
    Emitter<GameStatusState> emit,
  ) async {
    final temp = [...state.nextWords];
    temp.removeAt(0);
    emit(
      GameInProgress(
        currentWord: state.nextWords[0],
        nextWords: temp,
        correctWords: [...state.correctWords, state.currentWord],
        wrongWords: state.wrongWords,
      ),
    );

    add(const LoadNextWord(1));
  }

  Future<void> _wrongWord(
    WrongWord event,
    Emitter<GameStatusState> emit,
  ) async {
    final temp = [...state.nextWords];
    temp.removeAt(0);
    emit(
      GameInProgress(
        currentWord: state.nextWords[0],
        nextWords: temp,
        correctWords: state.correctWords,
        wrongWords: [...state.wrongWords, state.currentWord],
      ),
    );

    add(const LoadNextWord(1));
  }

  Future<void> _closeGame(
    GameIsOver event,
    Emitter<GameStatusState> emit,
  ) async {
    emit(
      GameCompleted(
        currentWord: state.currentWord,
        nextWords: state.nextWords,
        correctWords: state.correctWords,
        wrongWords: state.wrongWords,
      ),
    );
  }
}
