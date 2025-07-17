import 'dart:async';
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

  void _onFlipCard(FlipCard event, Emitter<GameState> emit) async {
    if (state.isCheckingMatch ||
        state.flippedCardIds.contains(event.cardId) ||
        state.cards.firstWhere((c) => c.id == event.cardId).isMatched) {
      return;
    }

    final updatedCards = state.cards.map((card) {
      if (card.id == event.cardId) {
        return card.copyWith(isFaceUp: true);
      }
      return card;
    }).toList();

    final newFlipped = [...state.flippedCardIds, event.cardId];

    emit(state.copyWith(cards: updatedCards, flippedCardIds: newFlipped));

    if (newFlipped.length == 2) {
      emit(state.copyWith(isCheckingMatch: true));

      await Future.delayed(const Duration(seconds: 1));

      final card1 = updatedCards.firstWhere((c) => c.id == newFlipped[0]);
      final card2 = updatedCards.firstWhere((c) => c.id == newFlipped[1]);

      bool isMatch = card1.content == card2.content;

      final newCards = updatedCards.map((card) {
        if (card.id == card1.id || card.id == card2.id) {
          return isMatch
              ? card.copyWith(isMatched: true)
              : card.copyWith(isFaceUp: false);
        }
        return card;
      }).toList();

      final allMatched = newCards.every((card) => card.isMatched);

      emit(
        state.copyWith(
          cards: newCards,
          flippedCardIds: [],
          isCheckingMatch: false,
          hasWon: allMatched,
          turns: state.turns + 1,
        ),
      );
    }
  }

  void _onResetGame(ResetGame event, Emitter<GameState> emit) {
    emit(GameState.initial(_generateInitialCards()));
  }
}
