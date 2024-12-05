import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:brick_breaker/game/menus/floating_button.dart';
import 'package:brick_breaker/game/menus/game_over.dart';
import 'package:brick_breaker/game/menus/pause_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../game/menus/continue_game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget<BrickBreakerWorld>.controlled(
      gameFactory: BrickBreakerWorld.new,
      backgroundBuilder: (context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/game_bg_overlay.png'),
            fit: BoxFit.fill,
          ),
          gradient: RadialGradient(
              colors: [AppTheme.bgColor1, AppTheme.bgColor2], radius: 0.9),
        ),
      ),
      overlayBuilderMap: {
        'GameOver': (_, game) => GameOver(game: game),
        'Pause': (_, game) => PauseMenu(game: game),
        'Boost': (_, game) => FloatingActionButtonOverlay(game: game),
        'ContinueGame': (_, game) => ContinueGame(game: game)
      },
      initialActiveOverlays: const ['Boost'],
    );
  }
}
