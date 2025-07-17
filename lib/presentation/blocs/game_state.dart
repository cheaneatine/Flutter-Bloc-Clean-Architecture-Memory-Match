import '../../domain/entities/card_entity.dart';

class GameState {
  final List<CardEntity> cards;
  final int turns;
  final bool hasWon;

  GameState({required this.cards, required this.turns, required this.hasWon});

  factory GameState.initial(List<CardEntity> cards) {
    return GameState(cards: cards, turns: 0, hasWon: false);
  }

  GameState copyWith({List<CardEntity>? cards, int? turns, bool? hasWon}) {
    return GameState(
      cards: cards ?? this.cards,
      turns: turns ?? this.turns,
      hasWon: hasWon ?? this.hasWon,
    );
  }
}
