import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/game_config.dart';

class ShopService {
  List<ShopItem> shopItemsList = GameConfig.shopItem;

  // buy item
  buyItem(ShopItem item) async {
    await updateInventory(item,true);
    await saveStarCount(-item.cost);
  }

  // load inventory items
  static Future<List<ShopItem>> loadInventory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? inventoryJson = prefs.getString('inventory');

    if (inventoryJson == null) {
      return [];
    }

    final List<dynamic> inventoryList = jsonDecode(inventoryJson);
    return inventoryList.map((json) => ShopItem.fromJson(json)).toList();
  }

  // update inventory
  static Future<void> updateInventory(ShopItem shopItem, bool isBuy) async {
    List<ShopItem> items = await loadInventory();
    if(items.isEmpty) {
      shopItem.count = 1;
      items.add(shopItem);
    } else {
      if(items.where((element) => element.id == shopItem.id).isNotEmpty){
        for(ShopItem item in items){
          if(item.id == shopItem.id) {
            if (isBuy) {
              item.count++;
            } else {
              item.count--;
            }
            break;
          }
        }
      } else {
          shopItem.count = 1;
          items.add(shopItem);
        }
      }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String inventoryJson = jsonEncode(items.map((item) => item.toJson()).toList());
    await prefs.setString('inventory', inventoryJson);
  }

  // load star count
  static Future<int> loadStarCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? star = prefs.getInt('star_count');
    if (star == null) {
      return 0;
    }
    return star;
  }

  // save star count
  static Future<void> saveStarCount(int newCount) async {
    int starCount = await loadStarCount();

    starCount = starCount + newCount;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('star_count', starCount);
  }
}

class ShopItem {
  String id;
  int cost;
  String name;
  String img;
  int count;
  int? noOfBalls;

  ShopItem({
    required this.id,
    required this.cost,
    required this.name,
    required this.img,
    this.noOfBalls,
    this.count = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cost': cost,
      'name': name,
      'img': img,
      'count': count,
      'noOfBalls': noOfBalls
    };
  }

  // Create a ShopItem instance from a JSON object
  factory ShopItem.fromJson(Map<String, dynamic> json) {
    return ShopItem(
      id: json['id'],
      cost: json['cost'],
      name: json['name'],
      img: json['img'],
      count: json['count'] ?? 0,
      noOfBalls: json['noOfBalls'],
    );
  }

  @override
  String toString() {
    return 'ShopItem{id: $id, cost: $cost, name: $name, img: $img, count: $count}';
  }
}
