import 'package:brick_breaker/config/theme.dart';
import 'package:brick_breaker/services/shop_service.dart';
import 'package:brick_breaker/ui/reusable/buttons/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../reusable/list_item_widget.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final shopService = ShopService();
  int stars = 0;
  List<ShopItem> list = [];

  @override
  void initState() {
    loadStarCount();
    loadShopItems();
    super.initState();
  }

  // load stars count
  loadStarCount() async {
    stars = await ShopService.loadStarCount();
    setState(() {});
  }

  // load inventory
  loadShopItems() async {
    list = await ShopService.loadInventory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_ovelay.png'),
            fit: BoxFit.fill,
          ),
          gradient: RadialGradient(colors: [AppTheme.bgColor1, AppTheme.bgColor2], radius: 0.9),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: ButtonWidget(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        width: 55,
                        height: 55,
                        icon: 'assets/icons/back.png',
                        btnType: ButtonType.icon2),
                  ),
                  Text(
                    'Shop',
                    style: TextStyle(
                        color: AppTheme.primaryTextColor,
                        fontFamily: AppTheme.primaryFont,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w900),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 16.w),
                    padding: EdgeInsets.only(left: 8.w, right: 12.w, top: 4.w, bottom: 4.w),
                    decoration: BoxDecoration(
                        gradient: const RadialGradient(
                            radius: 0.9,
                            colors: [AppTheme.fgColor2, AppTheme.fgColor1]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(2, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/star.png',
                          width: 24.w,
                          height: 24.w,
                        ),
                        8.horizontalSpace,
                        Text(
                          '$stars',
                          style: TextStyle(
                            color: AppTheme.primaryTextColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppTheme.primaryFont
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: shopService.shopItemsList.length,
                itemBuilder: (context, index) {
                  return ListItemWidget(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16.r)),
                                child: Image.asset(
                                  'assets/images/${shopService.shopItemsList[index].img}',
                                  width: 42.w,
                                  height: 42.w,
                                ),
                              ),
                              16.horizontalSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    shopService.shopItemsList[index].name,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontFamily: AppTheme.primaryFont,
                                        color: AppTheme.primaryTextColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 6.w),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/star.png',
                                          width: 20.w,
                                          height: 20.w,
                                        ),
                                        4.horizontalSpace,
                                        Text(
                                            '${shopService.shopItemsList[index].cost}',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontFamily: AppTheme.primaryFont,
                                                color: AppTheme.primaryTextColor,
                                                fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              gradient: stars >= shopService.shopItemsList[index].cost
                                  ? const LinearGradient(
                                colors: [
                                  AppTheme.primaryBtnColor1,
                                  AppTheme.iconColor, // Define the second color for the gradient
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ) : null,
                              color: stars >= shopService.shopItemsList[index].cost
                                  ? null
                                  : Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(18.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0,1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  color: Colors.black.withOpacity(0.5)
                                )
                              ]
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                disabledBackgroundColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.r), // <-- Radius
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 28.w), // Adjust padding if needed
                              ),
                              onPressed: stars >= shopService.shopItemsList[index].cost
                                  ? () async {
                                stars = stars - shopService.shopItemsList[index].cost;
                                await shopService.buyItem(shopService.shopItemsList[index]);
                                loadShopItems();
                              } : null,
                              child: Text(
                                'Buy',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: AppTheme.primaryFont,
                                  color: AppTheme.primaryTextColor.withOpacity(stars >= shopService.shopItemsList[index].cost ? 1 : 0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ]),
                  );
                },
              ),
            ),
            list.isNotEmpty
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 16.w, horizontal: 20.w),
                    padding: EdgeInsets.all(8.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(colors: [
                          AppTheme.fgColor1.withOpacity(0.6),
                          AppTheme.fgColor2.withOpacity(0.6)
                        ], radius: 2),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 3)
                        ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60.w,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) => list[index].count > 0
                                  ? Padding(
                                    padding: EdgeInsets.only(right:12.w),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8.w),
                                          decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(16.r),
                                          ),
                                          child: Image.asset('assets/images/${list[index].img}',width: 42.w,height: 42.w,),
                                        ),
                                        Positioned(
                                          top: -8,
                                          right: -8,
                                          child: Container(
                                            padding: EdgeInsets.all(4.w),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppTheme.iconColor),
                                            child: Center(
                                                child: Text(
                                              '${list[index].count}',
                                              style: const TextStyle(color: AppTheme.primaryTextColor),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                  : const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
