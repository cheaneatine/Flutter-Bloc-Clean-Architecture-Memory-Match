import 'package:flutter/material.dart';
import '../../domain/entities/card_entity.dart';
import 'dart:math';

class CardTile extends StatelessWidget {
  final CardEntity card;
  final VoidCallback onTap;

  const CardTile({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: card.isFaceUp || card.isMatched ? null : onTap,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween<double>(
          begin: 0,
          end: card.isFaceUp || card.isMatched ? 1 : 0,
        ),
        builder: (context, value, child) {
          final isFront = value < 0.5;
          final angle = value * pi;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isFront ? Colors.blueAccent : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black26),
              ),
              alignment: Alignment.center,
              child: isFront
                  ? const SizedBox.shrink()
                  : Text(card.content, style: const TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}
