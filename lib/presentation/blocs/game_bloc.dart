import 'package:flutter_bloc/flutter_bloc.dart';
import 'game_event.dart';
import 'game_state.dart';
import '../../domain/entities/card_entity.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.initial(_generateInitialCards())) {
    on<FlipCard>(_onFlipCard);
    on<ResetGame>(_onResetGame);
  }

  static List<CardEntity> _generateInitialCards() {
    final contents = ['🍎', '🍌', '🍓', '🍇', '🍉', '🍒', '🍍', '🥝'];
    final cards = [...contents, ...contents]
        .asMap()
        .entries
        .map((e) => CardEntity(id: e.key.toString(), content: e.value))
        .toList();
    cards.shuffle();
    return cards;
  }

  void _onFlipCard(FlipCard event, Emitter<GameState> emit) {
    // Implement flipping and match logic here
  }

  void _onResetGame(ResetGame event, Emitter<GameState> emit) {
    emit(GameState.initial(_generateInitialCards()));
  }
}
