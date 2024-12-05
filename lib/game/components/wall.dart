import 'package:brick_breaker/config/theme.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

List<Wall> createBoundaries(Forge2DGame game, {double? strokeWidth}) {
  final visibleRect = game.camera.visibleWorldRect;
  final topLeft = visibleRect.topLeft.toVector2();
  final topRight = visibleRect.topRight.toVector2();
  final bottomRight = visibleRect.bottomRight.toVector2();
  final bottomLeft = visibleRect.bottomLeft.toVector2();

  return [
    Wall(Vector2(topLeft.x,topLeft.y+6), Vector2(topRight.x,topRight.y+6), false, strokeWidth: strokeWidth),
    Wall(Vector2(topRight.x, topRight.y+6), bottomRight, false, strokeWidth: strokeWidth),
    Wall(bottomLeft, bottomRight, true, strokeWidth: strokeWidth),
    Wall(Vector2(topLeft.x,topLeft.y+6), bottomLeft, false, strokeWidth: strokeWidth),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final double strokeWidth;
  final bool isBottom;

  Wall(this.start, this.end, this.isBottom, {double? strokeWidth})
      : strokeWidth = strokeWidth ?? 1;

  @override
  Body createBody() {
    final shape = EdgeShape()..set(start, end);
    final fixtureDef = FixtureDef(shape, friction: 0,restitution: 1);
    final bodyDef = BodyDef(
      userData: this, // To be able to determine object in collision
      position: Vector2.zero(),
    );
    paint.strokeWidth = strokeWidth;
    paint.color = AppTheme.gameBorderColor1;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
