import 'dart:math';
import 'package:brick_breaker/config/game_config.dart';
import 'package:brick_breaker/game/components/black_hole.dart';
import 'package:brick_breaker/game/components/brick.dart';
import 'package:brick_breaker/game/components/collectable_ball.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../components/star.dart';

class BrickManager extends Component {
  final Forge2DGame game;
  final Random _random = Random();
  int difficultyLevel = 1;
  final Function onBrickHit;
  final Function onBallCollect;
  final Function onBlackHoleHit;
  final Function onStarCollect;
  double width = 5;
  double height = 5;
  final double rowSpace = 0.6;
  final double colSpace = 0.6;
  final double noOfCols = 7;
  Vector2 initialPos = Vector2(0, 0);


  BrickManager(this.game, this.onBrickHit, this.onBallCollect, this.onBlackHoleHit, this.onStarCollect){
    final visibleRect = game.camera.visibleWorldRect;
    final tl = visibleRect.topLeft.toVector2();
    width = (visibleRect.width-6-(colSpace*(noOfCols-1)))/noOfCols;
    height = width;
    initialPos = Vector2(tl.x, tl.y+6);
  }

  void addNewBrickRowToTop() {

    double brickProbability = (GameConfig.initialBrickProbability + difficultyLevel * GameConfig.brickProbabilityIncrement).clamp(0.1, GameConfig.maxBrickProbability);

    double ballProbability = (GameConfig.initialBallProbability + difficultyLevel * GameConfig.ballProbabilityIncrement).clamp(0.1, GameConfig.maxBallProbability);

    double holeProbability = (GameConfig.initialHoleProbability + difficultyLevel * GameConfig.holeProbabilityIncrement).clamp(0.1, GameConfig.maxHoleProbability);

    int hitCountMin = (GameConfig.initialHitCountMin + difficultyLevel * GameConfig.hitCountIncrement).clamp(GameConfig.initialHitCountMin, GameConfig.maxHitCount);
    int hitCountMax = (GameConfig.initialHitCountMax + difficultyLevel * GameConfig.hitCountIncrement).clamp(GameConfig.initialHitCountMax, GameConfig.maxHitCount);

    for (int col = 1; col <= noOfCols; col++) {
      final position = Vector2((initialPos.x + (width * col)+(colSpace*col)), (initialPos.y + height));
      if (_random.nextDouble() < brickProbability) {
        final hitCount = _random.nextInt(hitCountMax - hitCountMin + 1) + hitCountMin;
        final brick = Brick(
          startPosition: position,
          hitCount: hitCount,
          height: height,
          width: width,
          onBrickHit: onBrickHit
        );
        game.world.add(brick);
      } else {
        if (_random.nextDouble() < ballProbability) {
          final ball = CollectableBall(
            position,
            onBallCollect,
            radius: 0.8,
          );
          game.world.add(ball);
        } else if(_random.nextDouble() < holeProbability){
          final hole = BlackHole(
              startPosition: position,
              hitCount: 3,
              height: height,
              width: width,
              onBlackHoleHit: onBlackHoleHit
          );
          game.world.add(hole);
        } else if(_random.nextDouble() < 0.2){
          final star = CollectableStar(
              position: position,
              size: Vector2(3,3),
            collectStar: onStarCollect
          );
          game.world.add(star);
        }
      }
    }

    difficultyLevel++;
  }

  void moveBricksDown(int score,int star) {
    final bricks = game.world.children.whereType<Brick>().toList();
    if (bricks.isNotEmpty) {
      for (final brick in bricks) {
        brick.body.setTransform(brick.body.position + Vector2(0, height+rowSpace), 0);
      }
    }

    final collectables = game.world.children.whereType<CollectableBall>().toList();
    if(collectables.isNotEmpty) {
      for(final collectible in collectables) {
        collectible.body.setTransform(collectible.body.position + Vector2(0, height+rowSpace), 0);
      }
    }

    final holes = game.world.children.whereType<BlackHole>().toList();
    if(holes.isNotEmpty) {
      for (final hole in holes) {
        hole.body.setTransform(hole.body.position + Vector2(0, height+rowSpace), 0);
      }
    }

    final stars = game.world.children.whereType<CollectableStar>().toList();
    if(stars.isNotEmpty) {
      for (final star in stars) {
        star.body.setTransform(star.body.position + Vector2(0, height+rowSpace), 0);
      }
    }

    if(isGameOver()){
      game.pauseEngine();
      game.overlays.add('ContinueGame');
    } else {
      addNewBrickRowToTop();
    }
  }

  bool isGameOver() {
    final visibleRect = game.camera.visibleWorldRect;
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    for (final brick in game.world.children.whereType<Brick>()) {
      if(brick.body.position.y >= bottomLeft.y-6){
       return true;
      }
    }
    return false;
  }
}
