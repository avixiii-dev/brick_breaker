import 'dart:math';
import 'package:brick_breaker/config/game_config.dart';
import 'package:brick_breaker/game/components/black_hole.dart';
import 'package:brick_breaker/game/components/collectable_ball.dart';
import 'package:brick_breaker/game/managers/ball_manager.dart';
import 'package:brick_breaker/game/components/score_bar.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'components/ball.dart';
import 'components/brick.dart';
import 'components/wall.dart';
import 'components/star.dart';
import 'managers/brick_manager.dart';

class BrickBreakerWorld extends Forge2DGame with PanDetector {
  late Vector2 _fixedStart; // Fixed start position for the trajectory line
  Vector2 _currentTouch = Vector2.zero(); // Current touch position
  bool _isDragging = false; // Flag to indicate if dragging is in progress

  bool ballsInPlay = false;
  late BrickManager brickManager;
  late BallManager ballManager;
  late TopBar topBar;
  late TextComponent ballCountText;
  int ballsCounts = 1;
  bool isMute = false;

  BrickBreakerWorld() : super(gravity: Vector2.all(0.0));

  @override
  Future<void> onLoad() async {
    super.onLoad();

    _fixedStart = Vector2(size.x / 2, size.y);

    await Flame.images.load('bricks.png');

    final boundaries = createBoundaries(this, strokeWidth: 0.5);
    world.addAll(boundaries);

    topBar = TopBar();
    add(topBar);

    addBallsText();

    initializeGame();
  }

  initializeGame(){
    brickManager = BrickManager(this, () => topBar.updateScore(),collectBall,removeBall,collectStar);
    brickManager.addNewBrickRowToTop();

    ballManager = BallManager(this);
    ballManager.addPlayer();

    _fixedStart = worldToScreen(ballManager.playerPosition);
  }

  collectBall(){
    ballManager.collectBall();
    ballsCounts++;
  }

  addBalls(int count){
    ballManager.addBalls(count);
    ballsCounts = ballsCounts + count;
  }

  collectStar(){
    topBar.updateStars();
  }

  removeBall(){
    ballManager.removeBall();
    if(ballsCounts > 0){
      ballsCounts--;
    }else{
      pauseEngine();
      overlays.add('ContinueGame');
    }
  }

  resetGame(){
    final componentsToRemove = world.children.whereType<Component>().toList();
    for (final component in componentsToRemove) {
      if(component is Ball || component is Brick || component is CollectableBall || component is SpriteComponent || component is BlackHole || component is CollectableStar) {
        component.removeFromParent(); // Remove the component from the game
      }
    }
    ballsInPlay = false;
    ballsCounts = 1;

    topBar.resetData();
    initializeGame();
  }

  @override
  void onPanStart(DragStartInfo info) {
    _isDragging = true; // Set dragging flag to true
    _currentTouch = info.eventPosition.global; // Capture the initial touch position
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    if(!ballsInPlay) {
      _currentTouch = info.eventPosition.global; // Update current touch position

      // Calculate the difference between the touch position and the gun's position
      final delta = _currentTouch - _fixedStart;

      // Calculate the angle using atan2
      final angle = atan2(delta.y, delta.x);

      // Adjust the angle so that 0 radians points upwards
      ballManager.player.angle =
      (angle - (pi / 2) * 3); // Rotate by -90 degrees
    }
  }

  @override
  Future<void> onPanEnd(DragEndInfo info) async {
    _isDragging = false;
    if (!ballsInPlay) {
      ballManager.releaseBalls((_currentTouch - _fixedStart)); // Release the balls when the pan ends
      ballsInPlay = true;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _fixedStart = worldToScreen(ballManager.playerPosition);

    if (_isDragging && !ballsInPlay) {
      final paint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2.0;

      // Set the length of the dotted line
      double dotSpacing = 10.0;  // Spacing between dots

      // Calculate the direction from the fixed start to the current touch position
      final direction = (_currentTouch - _fixedStart).normalized();

      // Starting point of the line (a bit above the fixed start)
      final startOffset = Offset(_fixedStart.x, _fixedStart.y);

      // Loop to draw the dotted line
      for (double i = 0; i <= GameConfig.aimLength; i += dotSpacing) {
        final dotPosition = startOffset +
            Offset(direction.x * i, direction.y * i);

        canvas.drawCircle(dotPosition, 2.0, paint);
      }
    }
  }

  addBallsText(){
    // Define the radius for the circle
    const circleRadius = 16.0;

    // Create the circle component
    final circleComponent = CircleComponent(
      radius: circleRadius,
      paint: Paint()..color = Colors.blue,  // Change the color as needed
      priority: 9,  // Ensures it's behind the text
    )..position = Vector2(circleRadius, size.y - (circleRadius*2)-16);

    // Create the text component
    ballCountText = TextComponent(
      text: 'x$ballsCounts',
      priority: 10,  // Ensure text is above the circle
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );

    // Center the text within the circle
    ballCountText.position = Vector2(
      circleComponent.size.x / 2 - ballCountText.size.x / 2,
      circleComponent.size.y / 2 - ballCountText.size.y / 2,
    );

    // Add both components to the game
    add(circleComponent);
    circleComponent.add(ballCountText);  // Adding text as a child of the circle to maintain relative position
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check if any ball hits the ground and stop it
    if (ballsInPlay && ballManager.ballsCount > 0 && ballManager.isBallsHitGround()) {
      brickManager.moveBricksDown(topBar.score, topBar.starCount);
      ballsInPlay = false;
    } else if(ballsInPlay && ballManager.ballsCount == 0){
      pauseEngine();
      overlays.add('ContinueGame');
    }

    ballCountText.text = 'x$ballsCounts';
  }

  // enable brick breaker mode
  enableBrickBreaker(){
    final allBricks = world.children.whereType<Brick>().toList();
    if(allBricks.isNotEmpty){
      for (Brick brick in allBricks) {
        brick.enableBrickBreakerMode(true);
      }
    }
  }

  // resume game after watching add
  resumeGame(){
    final bricksList = world.children.whereType<Brick>().toList();
    if(ballsCounts > 0) {
      final toRemove = bricksList.getRange(0, 6).toList();
      for (var element in toRemove) {
        element.removeFromParent();
      }
    }
    if(ballsCounts <= 0){
      ballsCounts = 1;
      ballManager.addBalls(1);
    }
    ballsInPlay = false;
    resumeEngine();
    overlays.remove('ContinueGame');
  }
}
