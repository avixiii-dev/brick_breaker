import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'ball.dart';

class BlackHole extends BodyComponent with ContactCallbacks{
  final Vector2 startPosition;
  final double width;
  final double height;
  final BodyType bodyType;
  int hitCount;
  bool isBroken = false;
  bool hitGround = false;
  final Function onBlackHoleHit;
  late List<Sprite> brickSprites; // Sprites for the brick

  BlackHole({
    required this.startPosition,
    required this.hitCount,
    required this.width,
    required this.height,
    required this.onBlackHoleHit,
    this.bodyType = BodyType.static,
  }) {
    final spriteSheet = SpriteSheet(
      image: Flame.images.fromCache('bricks.png'),spacing: 8,
      srcSize: Vector2(56, 56), // Size of individual sprites in the sprite sheet
    );

    // Extract the 4 sprites for different brick states based on hit count
    brickSprites = [
      spriteSheet.getSprite(0, 0), // Sprite for max hit count
      spriteSheet.getSprite(0, 1), // Sprite for medium hit count
      spriteSheet.getSprite(0, 2), // Sprite for low hit count
      spriteSheet.getSprite(0, 3), // Sprite for almost broken
    ];
  }

  @override
  Body createBody() {
    final shape = PolygonShape()
      ..setAsBox(width / 2, height / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0,
      restitution: 1,
      density: 0,
      isSensor: true
    );
    final bodyDef = BodyDef(
      position: startPosition,
      type: BodyType.static, // Bricks are static until hit
      userData: this, // Store a reference to this brick
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderPolygon(Canvas canvas, List<Offset> points) {
    super.renderPolygon(canvas, points);

    paint = const PaletteEntry(Colors.transparent).paint();

    // Get the appropriate sprite based on the hit count
    final currentBrickSprite = getCurrentBrickSprite();

    // Render the current sprite instead of using a solid color
    currentBrickSprite.renderRect(
      canvas,
      Rect.fromLTWH(points[0].dx, points[0].dy, width, height),
    );

    canvas.drawCircle(const Offset(0, 0), hitCount*0.7, const PaletteEntry(Colors.black).paint());
  }

  Sprite getCurrentBrickSprite() {
    // Determine which sprite to use based on hit count
    if (hitCount >= 4) {
      return brickSprites[3]; // Full health sprite
    } else if (hitCount > 3) {
      return brickSprites[2]; // Medium health sprite
    } else if (hitCount > 2) {
      return brickSprites[1]; // Low health sprite
    } else {
      return brickSprites[0]; // Almost broken sprite
    }
  }

  void hit() {
    hitCount--;
    if (hitCount <= 0) {
      removeFromParent();
    }
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      other.removeFromParent();
      other.isBottomHit = true;
      onBlackHoleHit();
      hit();
    }
  }

}