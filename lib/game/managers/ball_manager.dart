import 'package:brick_breaker/config/game_config.dart';
import 'package:brick_breaker/game/components/ball.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class BallManager extends Component {
  final Forge2DGame game;
  List<Ball> ballsList = [];
  int ballsCount = 1;
  late SpriteComponent player;
  Vector2 playerPosition = Vector2(0,0);

  BallManager(this.game){
    final visibleRect = game.camera.visibleWorldRect;
    final bottomLeft = visibleRect.bottomLeft.toVector2();
    playerPosition = Vector2(0,bottomLeft.y - 1);
  }

  void addPlayer() async {
    final visibleRect = game.camera.visibleWorldRect;
    final bottomLeft = visibleRect.bottomLeft.toVector2();
    player = SpriteComponent(
        size: Vector2(6,7),
        position: playerPosition, // Vector2(0, bottomLeft.y - 1),
        sprite: await Sprite.load('shooter.png'),
        priority: 1,
      anchor: Anchor.bottomCenter
    );
    game.world.add(player);
  }

  void spawnBall() {
    final visibleRect = game.camera.visibleWorldRect;
    final bottomLeft = visibleRect.bottomLeft.toVector2();
    ballsList.clear();
    ballsList = List.generate(
        ballsCount,
        (index) => Ball(Vector2(playerPosition.x, bottomLeft.y - 1),
            onBallHistGround: onBallHitGround,
            ));
    game.world.addAll(ballsList);
  }

  void releaseBalls(direction) {
    spawnBall();
    for (int i = 0; i < ballsList.length; i++) {
      final normalizedDirection = direction.normalized();

      // Apply impulse to each ball sequentially with a slight delay
      Future.delayed(Duration(milliseconds: i * GameConfig.delayBtwBalls), () {
        ballsList[i].throwBall(normalizedDirection * GameConfig.shootForce);
      });
    }
  }

  bool isBallsHitGround() {
    if (ballsList.isNotEmpty) {
      if(ballsList.every((element) => element.isBottomHit)){
        return true;
      }
    }
    return false;
  }

  collectBall(){
    ballsCount++;
  }

  addBalls(int count){
    ballsCount = ballsCount + count;
  }

  removeBall(){
    ballsCount--;
  }

  onBallHitGround(Vector2 position){
    if(isBallsHitGround()) {
      final visibleRect = game.camera.visibleWorldRect;
      final bottomLeft = visibleRect.bottomLeft.toVector2();
      player.position = Vector2(position.x, bottomLeft.y - 1);
      player.angle = 0;
      playerPosition = Vector2(position.x, bottomLeft.y - 1);
    }
  }

}
