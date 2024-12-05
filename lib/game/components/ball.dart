import 'package:brick_breaker/config/theme.dart';
import '../managers/audio_manager.dart';
import 'wall.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'brick.dart';

class Ball extends BodyComponent with ContactCallbacks {
  late Paint originalPaint; // Paint used for the ball's original color
  final double radius; // Radius of the ball
  final BodyType bodyType; // Type of body (dynamic/static) for physics simulation
  final Vector2 _position; // Initial position of the ball in the world
  bool isBottomHit = false;
  late Fixture fixture; // Store the fixture to modify collision filter later
  Function(Vector2 position) onBallHistGround;

  Ball(
    this._position,{
      this.radius = 0.8,
        required this.onBallHistGround,
        this.bodyType = BodyType.dynamic,
  }) {
    paint = const PaletteEntry(AppTheme.ballsColor).paint();
  }

  // Create the physics body for the ball
  @override
  Body createBody() {
    // Define a circular shape for the ball
    final shape = CircleShape();
    shape.radius = radius;

    // Define the physical properties of the ball
    final fixtureDef = FixtureDef(
      shape,
      restitution: 1, // Bounciness of the ball
      friction: 0, // Friction between the ball and surfaces
    );

    // Define the body's initial properties
    final bodyDef = BodyDef(
      userData: this, // Attach the Ball instance as user data
      angularDamping: 0,
      linearDamping: 0, // Angular damping to slow down rotation
      position: _position, // Initial position of the body
      type: bodyType,
    );
    // Create the body in the physics world and attach the fixture
    Body body = world.createBody(bodyDef);
    fixture = body.createFixture(fixtureDef);

    // Disable collision initially
    final noCollisionFilter = Filter();
    noCollisionFilter.categoryBits = 0x0000; // No collision category
    noCollisionFilter.maskBits = 0x0000; // No collision mask
    fixture.filterData = noCollisionFilter; // Apply the filter to the fixture

    return body;
  }

  // Update method called every frame
  @override
  @mustCallSuper
  void update(double dt) {
    if (isBottomHit) {
      hitGround();
    }

    // Enforce minimum speed to prevent the ball from slowing down too much
    const double minSpeed = 61.0; // Define a minimum speed threshold
    final currentSpeed = body.linearVelocity.length;
    if (currentSpeed < minSpeed) {
      final normalizedVelocity = body.linearVelocity.normalized();
      body.linearVelocity = normalizedVelocity * minSpeed;
    }
  }

  hitGround(){
    body.linearVelocity = Vector2.zero();
    body.angularVelocity = 0;
    body.setType(BodyType.static); // Make the ball static
    body.clearForces();
    removeFromParent();
  }

  // Callback method when the ball starts contact with another object
  @override
  void beginContact(Object other, Contact contact) {
    if (other is Wall) {
      if (other.isBottom) {
        isBottomHit = true;
        onBallHistGround(position);
      }
    }
    if (other is Brick) {
      other.hit();
      final audioManger = AudioManager();
      audioManger.play('hit_brick');
    }
    if (other is Ball) {
      if (other.isBottomHit) {
        isBottomHit = true;
      }
    }
  }

  throwBall(Vector2 impulse) {
    final originalFilter = Filter();
    originalFilter.categoryBits = 0x0001; // Set the appropriate category
    originalFilter.maskBits = 0xFFFF; // Set the appropriate mask
    fixture.filterData = originalFilter; // Restore the original collision filter
    body.applyLinearImpulse(impulse);
  }
}
