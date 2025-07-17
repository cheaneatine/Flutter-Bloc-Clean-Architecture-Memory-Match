abstract class GameEvent {}

class FlipCard extends GameEvent {
  final String cardId;
  FlipCard(this.cardId);
}

class ResetGame extends GameEvent {}
