class CardEntity {
  final String id;
  final String content;
  final bool isFaceUp;
  final bool isMatched;

  CardEntity({
    required this.id,
    required this.content,
    this.isFaceUp = false,
    this.isMatched = false,
  });

  CardEntity copyWith({bool? isFaceUp, bool? isMatched}) {
    return CardEntity(
      id: id,
      content: content,
      isFaceUp: isFaceUp ?? this.isFaceUp,
      isMatched: isMatched ?? this.isMatched,
    );
  }
}
