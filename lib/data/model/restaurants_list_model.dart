import 'dart:convert';

class RestaurantsListResultModel {
  final bool error;
  final String message;
  final int count;
  final List<RestaurantListModel> restaurant;

  RestaurantsListResultModel({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurant,
  });

  factory RestaurantsListResultModel.fromJson(Map<String, dynamic> json) {
    var restaurantsItem = json['restaurants'] as List;
    List<RestaurantListModel> dataRestaurantsList =
        restaurantsItem.map((i) => RestaurantListModel.fromJson(i)).toList();

    return RestaurantsListResultModel(
      error: json['error'],
      message: 'message',
      count: json['count'],
      restaurant: dataRestaurantsList,
    );
  }
}

class RestaurantListModel {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  RestaurantListModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantListModel.fromJson(Map<String, dynamic> restaurant) {
    return RestaurantListModel(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId: restaurant['pictureId'],
      city: restaurant['city'],
      rating: restaurant['rating'].toDouble(),
    );
  }
}
