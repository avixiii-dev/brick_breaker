import 'dart:math';
import 'package:brick_breaker/config/theme.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Brick extends BodyComponent with TapCallbacks{
  final Vector2 startPosition;
  final double width;
  final double height;
  final BodyType bodyType;
  int hitCount;
  bool isBroken = false;
  bool hitGround = false;
  final Function onBrickHit;
  bool brickBreakerMode = false;

  // Variables for the shaking animation
  double shakeTime = 0.0;
  final double shakeDuration = 0.5; // Shake duration in seconds
  final double shakeIntensity = 0.05; // How much the brick shakes

  final double shakeAngle = 0.05; // Max rotation in radians (about 2.9 degrees)
  // Store rotation angle
  double currentAngle = 0.0;
  bool isShaking = false;
  double elapsedTime = 0.0; // Time accumulator for sinusoidal rotation

  late List<Sprite> brickSprites; // Sprites for the brick


  Brick({
    required this.startPosition,
    required this.hitCount,
    required this.width,
    required this.height,
    required this.onBrickHit,
    this.bodyType = BodyType.static,
  }) {
      // Load the sprite sheet and initialize the brick sprites
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
    );
    final bodyDef = BodyDef(
      position: startPosition,
      type: BodyType.static, // Bricks are static until hit
      userData: this, // Store a reference to this brick
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }


  Sprite getCurrentBrickSprite() {
    // Determine which sprite to use based on hit count
    if (hitCount > 12) {
      return brickSprites[3]; // Full health sprite
    } else if (hitCount > 8) {
      return brickSprites[2]; // Medium health sprite
    } else if (hitCount > 3) {
      return brickSprites[1]; // Low health sprite
    } else {
      return brickSprites[0]; // Almost broken sprite
    }
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


    // Draw the hit count text on top of the brick
    final textPainter = TextPainter(
      maxLines: 1,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: hitCount.toString(),
        style: TextStyle(
          color: hitCount > 12 ? const Color(0xff9E606B) : const Color(0xff5C254D), // Text color
          fontSize: 2.0, // Adjust the size as needed
          fontWeight: FontWeight.w600,
            fontFamily: AppTheme.primaryFont
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Calculate the position to center the text
    final textPosition = Offset(
      points[0].dx + (width - textPainter.width)/2, // textPainter.width
      points[0].dy + (height - textPainter.height)/2,
    );

    textPainter.paint(canvas, textPosition);
  }

  void hit() {
    hitCount--;
    if (hitCount <= 0) {
      isBroken = true;
      removeFromParent();
    }
    onBrickHit();
  }

  @override
  void update(double dt) {

    // Apply glowing effect when canBeRemovedOnTap is true
    if (brickBreakerMode) {
      // Start shaking (rotation)
      isShaking = true;
    } else {
      // Stop shaking and reset angle
      isShaking = false;
      body.setTransform(body.position, 0);
      elapsedTime = 0.0; // Reset elapsed time// Reset the angle to 0
    }

    // Apply shaking rotation
    // Apply shaking rotation (slower, sinusoidal effect)
    if (isShaking) {
      elapsedTime += dt;
      const double frequency = 5.0;  // Lower frequency for slower oscillation
      const double amplitude = 0.08; // Smaller angle for less rotation

      // Use a sinusoidal function to smoothly oscillate the rotation angle
      currentAngle = sin(elapsedTime * frequency) * amplitude;

      body.setTransform(body.position, currentAngle);  // Apply the rotation to the body
    }

  }

  @override
  void onTapDown(TapDownEvent event) {
    if (brickBreakerMode) {
      isBroken = true;
      removeFromParent();
      final allBricks = world.children.whereType<Brick>().toList();
      if(allBricks.isNotEmpty){
        for (Brick brick in allBricks) {
          brick.enableBrickBreakerMode(false);
        }
      }
    }
  }

  enableBrickBreakerMode(bool status) {
    brickBreakerMode = status;
  }
}