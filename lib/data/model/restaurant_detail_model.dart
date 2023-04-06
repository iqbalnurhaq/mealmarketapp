import 'dart:convert';

class RestaurantDetailResultModel {
  final bool error;
  final String message;
  final RestaurantDetail restaurant;

  RestaurantDetailResultModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailResultModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResultModel(
      error: json['error'],
      message: json['message'],
      restaurant: RestaurantDetail.fromJson(json['restaurant']),
    );
  }
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final MenuItem menus;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> restaurant) {
    return RestaurantDetail(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: restaurant['rating'].toDouble(),
      menus: MenuItem.fromJson(restaurant['menus']),
    );
  }
}

class MenuItem {
  final List<FoodItem> foods;
  final List<DrinkItem> drinks;

  MenuItem({
    required this.foods,
    required this.drinks,
  });

  factory MenuItem.fromJson(Map<String, dynamic> menuItem) {
    var foodsItem = menuItem['foods'] as List;
    var drinksItem = menuItem['drinks'] as List;
    List<FoodItem> dataFoodsItem =
        foodsItem.map((i) => FoodItem.fromJson(i)).toList();
    List<DrinkItem> dataDrinksItem =
        drinksItem.map((i) => DrinkItem.fromJson(i)).toList();

    return MenuItem(
      foods: dataFoodsItem,
      drinks: dataDrinksItem,
    );
  }
}

class FoodItem {
  final String name;

  FoodItem({required this.name});

  factory FoodItem.fromJson(Map<String, dynamic> foodItem) => FoodItem(
        name: foodItem['name'] ?? "",
      );
}

class DrinkItem {
  final String name;

  DrinkItem({required this.name});

  factory DrinkItem.fromJson(Map<String, dynamic> drinkItem) => DrinkItem(
        name: drinkItem['name'] ?? "",
      );
}
