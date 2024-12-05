import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/game/game.dart';
import 'package:brick_breaker/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/ball.dart';

class FloatingActionButtonOverlay extends StatefulWidget {
  final BrickBreakerWorld game;

  const FloatingActionButtonOverlay({required this.game, Key? key})
      : super(key: key);

  @override
  State<FloatingActionButtonOverlay> createState() =>
      _FloatingActionButtonOverlayState();
}

class _FloatingActionButtonOverlayState
    extends State<FloatingActionButtonOverlay> {
  bool isExpanded = false;
  List<ShopItem> list = [];

  @override
  void initState() {
    loadShopItems();
    super.initState();
  }

  loadShopItems() async {
    list = await ShopService.loadInventory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Column(
          children: isExpanded ? list
              .map(
                (e) => e.count > 0 ? Column(
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.black.withOpacity(0.6),
                      onPressed: ()=> useItem(e),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Image.asset('assets/images/${e.img}'),
                          ),
                          Positioned(
                            top: -2,
                            right: 1,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppTheme.iconColor
                              ),
                              child: Center(child: Text('${e.count}',style: TextStyle(fontSize:16.sp, color: AppTheme.primaryTextColor),)),
                            ),
                          )
                        ],
                      ),
                    ),
                    10.verticalSpace,
                  ],
                ): const SizedBox.shrink(),
              )
              .toList() : [],
        ),
        isExpanded ? FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.6),
          onPressed: (){
            final balls = widget.game.world.children.whereType<Ball>().toList();
            if(balls.isNotEmpty){
              for (Ball ball in balls) {
                ball.isBottomHit = true;
              }
            }
          },
          child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.ballsColor
              ),
              child: Icon(Icons.keyboard_double_arrow_down_rounded,size: 35.w,)),
        ) : const SizedBox.shrink(),
        10.verticalSpace,
        // Main FAB
        FloatingActionButton(
          backgroundColor: AppTheme.bgColor1.withOpacity(0.4),
          onPressed: toggleFab,
          child: Icon(isExpanded ? Icons.close : Icons.rocket_launch, color: Colors.white),
        ),
      ]),
    );
  }

  // Method to toggle the expanded state of the floating button
  void toggleFab() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void useItem(ShopItem item){
    if(item.id.contains('BALL') && item.noOfBalls != null) {
      widget.game.addBalls(item.noOfBalls!);
    } else if(item.id.contains('BRICK')){
      widget.game.enableBrickBreaker();
    }
    for (var element in list) {
      if(item.id == element.id) {
        element.count--;
        break;
      }
    }
    list.removeWhere((element) => element.count <= 0);
    setState(() {
      isExpanded = !isExpanded;
    });
    ShopService.updateInventory(item, false);
  }
}
