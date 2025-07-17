import '../../domain/entities/card_entity.dart';

class GameState {
  final List<CardEntity> cards;
  final int turns;
  final bool hasWon;
  final List<String> flippedCardIds;
  final bool isCheckingMatch;

  GameState({
    required this.cards,
    required this.turns,
    required this.hasWon,
    this.flippedCardIds = const [],
    this.isCheckingMatch = false,
  });

  factory GameState.initial(List<CardEntity> cards) {
    return GameState(cards: cards, turns: 0, hasWon: false);
  }

  GameState copyWith({
    List<CardEntity>? cards,
    int? turns,
    bool? hasWon,
    List<String>? flippedCardIds,
    bool? isCheckingMatch,
  }) {
    return GameState(
      cards: cards ?? this.cards,
      turns: turns ?? this.turns,
      hasWon: hasWon ?? this.hasWon,
      flippedCardIds: flippedCardIds ?? this.flippedCardIds,
      isCheckingMatch: isCheckingMatch ?? this.isCheckingMatch,
    );
  }
}
