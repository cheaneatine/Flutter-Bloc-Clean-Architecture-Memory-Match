import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/game_bloc.dart';
import '../blocs/game_event.dart';
import '../blocs/game_state.dart';
import '../widgets/theme_toggle.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        actions: const [ThemeToggle()],
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          return Center(child: Text('Game grid and cards go here'));
        },
      ),
    );
  }
}
