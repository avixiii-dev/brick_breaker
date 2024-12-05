import 'package:brick_breaker/config/theme.dart';
import 'package:flame/palette.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '../managers/audio_manager.dart';
import 'ball.dart';

class CollectableBall extends BodyComponent with ContactCallbacks {
  late Paint originalPaint; // Paint used for the ball's original color
  final double radius; // Radius of the ball
  final BodyType
  bodyType; // Type of body (dynamic/static) for physics simulation
  final Vector2 _position; // Initial position of the ball in the world
  bool isBottomHit = false;
  late Fixture fixture; // Store the fixture to modify collision filter later
  final Function ballCollected;

  CollectableBall(
      this._position, this.ballCollected, {
        this.radius = 0.8,
        this.bodyType = BodyType.static,
      }) {
    paint =  const PaletteEntry(AppTheme.collectibleBallsColor).paint();
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
      isSensor: true, // Set the ball as a sensor to avoid affecting player physics
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

    return body;
  }

  // Callback method when the ball starts contact with another object
  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      removeFromParent();
      final audioManger = AudioManager();
      audioManger.play('collect_ball');
      ballCollected();
    }
  }
}
