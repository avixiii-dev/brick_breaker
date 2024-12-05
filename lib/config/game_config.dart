import '../services/shop_service.dart';

class GameConfig {

  // aim line length
  static const double aimLength = 350.0;
  // ball shooting force
  static const double shootForce = 2500.0;
  // delay between ball in milliseconds
  static const int delayBtwBalls = 100;

  // brick generating
  static const double initialBrickProbability = 0.3;
  static const double brickProbabilityIncrement = 0.0005;
  static const double maxBrickProbability = 0.6;

  // ball generating
  static const double initialBallProbability = 0.05;
  static const double maxBallProbability = 0.3;
  static const double ballProbabilityIncrement = 0.008;

  // black holes generating
  static const double initialHoleProbability = 0.05;
  static const double maxHoleProbability = 0.2;
  static const double holeProbabilityIncrement = 0.005;

  // hit counts
  static const  int initialHitCountMin = 1;
  static const  int initialHitCountMax = 2;
  static const  int maxHitCount = 15;
  static const  int hitCountIncrement = 1;

  // shop items
  static List<ShopItem> shopItem = [
     ShopItem(id: 'BALL_2', cost: 2, name: '+2 Balls', img: 'add_ball_2.png', noOfBalls: 2),
     ShopItem(id: 'BALL_3', cost: 5, name: '+3 Balls', img: 'add_ball_3.png', noOfBalls: 3),
     ShopItem(id: 'BALL_5', cost: 8, name: '+5 Balls', img: 'add_ball_5.png', noOfBalls: 5),
     ShopItem(id: 'BRICK_SINGLE', cost: 4, name: 'Brick Breaker', img: 'break_brick.png')];
}