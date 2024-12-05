import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class TopBar extends PositionComponent with HasGameReference<BrickBreakerWorld> {
  int score = 0;
  int starCount = 0;
  late TextComponent scoreText;
  late TextComponent starCountText;
  late SpriteButtonComponent pauseButton;
  late SpriteComponent starSprite;
  late PositionComponent starCountWrapper;

  TopBar() {
    size = Vector2(size.x, 20); // Size of the top bar
    anchor = Anchor.topCenter; // Anchor the top center of the screen
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Create the score text component
    scoreText = TextComponent(
      text: '$score',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontFamily: AppTheme.primaryFont,
          fontWeight: FontWeight.w900
        ),
      ),
    )..anchor = Anchor.center
      ..position = Vector2(game.size.x / 2, 30); // Centered in the top bar


    // Star Sprite and Count Wrapper with gradient background
    final star = await Sprite.load('star.png');
    final starSprite = SpriteComponent(
      sprite: star,
      size: Vector2(30, 30),
      anchor: Anchor.center,
    );

    starCountText = TextComponent(
      text: '$starCount',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    )..anchor = Anchor.center;

    starCountWrapper = PositionComponent(
      size: Vector2(80, 40), // Size of the gradient square
      anchor: Anchor.topLeft,
      position: Vector2(12, 10),
      children: [
        RectangleComponent( // Gradient background
          size: Vector2(80, 40),
          paint: Paint()..color=Colors.transparent
          //   ..shader = RadialGradient(
          //     colors: [AppTheme.fgColor2.withOpacity(0.5), AppTheme.fgColor1.withOpacity(0.5)],
          //     // begin: Alignment.topLeft,
          //     // end: Alignment.bottomRight,
          //   ).createShader(Rect.fromLTWH(0, 0, 80, 40)),
        ),
        starSprite
          ..position = Vector2(20, 20), // Adjust position inside the wrapper
        starCountText
          ..position = Vector2(60, 20), // Adjust position beside the star
      ],
    );

    //
    // starCountText = TextComponent(
    //   text: '$starCount',
    //   textRenderer: TextPaint(
    //     style: const TextStyle(
    //       color: Colors.white,
    //       fontSize: 20,
    //     ),
    //   ),
    // )..position = Vector2(48, 16); // Position on the top left

    final buttonSprite = await Sprite.load('pause_button.png');

    // Load pause button sprite
    pauseButton = SpriteButtonComponent(
      onPressed: (){
        game.overlays.add('Pause');
        game.pauseEngine();
      },
      button: buttonSprite,
      buttonDown: buttonSprite,
      position: Vector2(game.size.x-54,8),
      size: Vector2(45,45)
    );

    // final star = await Sprite.load('star.png');
    //
    // // Load pause button sprite
    // starSprite = SpriteComponent(
    //     sprite: star,
    //     position: Vector2(12,12),
    //     size: Vector2(30,30)
    // );

    add(scoreText);
    // add(ballCountText);
    add(pauseButton as Component);
    add(starCountWrapper);
    // add(starSprite);

  }

  @override
  void render(Canvas canvas) {
    // Draw the gradient background
    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [AppTheme.gameBorderColor2,AppTheme.gameBorderColor1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, game.size.x, 60));

    canvas.drawRect(Rect.fromLTWH(0, 0, game.size.x, 60), paint);

    // Call the parent class render method to render child components
    super.render(canvas);
  }


  void updateScore() {
    score++;
    scoreText.text = '$score';
  }

  void updateStars() {
    starCount++;
    starCountText.text = '$starCount';
  }

  void resetData() {
    score = 0;
    starCount = 0;
    starCountText.text = '$starCount';
    scoreText.text = '$score';
  }
}
