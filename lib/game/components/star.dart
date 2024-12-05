import 'package:brick_breaker/game/components/ball.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../managers/audio_manager.dart';

class CollectableStar extends BodyComponent with ContactCallbacks {
  late Sprite starSprite;
  @override
  final Vector2 position;
  final Vector2 size;
  Function collectStar;

  CollectableStar({required this.size, required this.position, required this.collectStar});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = await game.loadSprite('star.png');
    renderBody = false;
    add(
      SpriteComponent(
        sprite: sprite,
        size: size,
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = PolygonShape()
      ..setAsBox(5 / 2, 5 / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(
      shape,
      friction: 0,
      restitution: 1,
      density: 0,
      isSensor: true
    );
    final bodyDef = BodyDef(
      position: position,
      type: BodyType.static, // Bricks are static until hit
      userData: this, // Store a reference to this brick
    );

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    if (other is Ball) {
      collectStar();
      final audioManger = AudioManager();
      audioManger.play('collect_star');
      removeFromParent();
    }
  }
}
