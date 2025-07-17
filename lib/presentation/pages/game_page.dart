// lib/presentation/pages/game_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game_bloc.dart';
import '../blocs/game_event.dart';
import '../blocs/game_state.dart';
import '../widgets/theme_toggle.dart';
import '../widgets/card_tile.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    final double boardSize = isPortrait
        ? screenSize.width * 0.9
        : screenSize.height * 0.7;

    final double tileSize = boardSize / 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        actions: const [ThemeToggle()],
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Turns: ${state.turns}'),
                    const SizedBox(height: 8),
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: tileSize * 4,
                    height: tileSize * 4,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 1,
                          ),
                      itemCount: state.cards.length,
                      itemBuilder: (context, index) {
                        final card = state.cards[index];
                        return CardTile(
                          card: card,
                          onTap: () =>
                              context.read<GameBloc>().add(FlipCard(card.id)),
                        );
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    if (state.hasWon)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('You Win!', style: TextStyle(fontSize: 20)),
                      ),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<GameBloc>().add(ResetGame()),
                      child: const Text('Restart'),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
