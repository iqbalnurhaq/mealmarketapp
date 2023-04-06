import 'package:mealmarketapp/data/model/restaurants_list_model.dart';

class RestaurantsSearchResultModel {
  final bool error;
  final int founded;
  final List<RestaurantListModel> restaurant;

  RestaurantsSearchResultModel({
    required this.error,
    required this.founded,
    required this.restaurant,
  });

  factory RestaurantsSearchResultModel.fromJson(Map<String, dynamic> json) {
    var restaurantsItem = json['restaurants'] as List;
    List<RestaurantListModel> dataRestaurantsList =
        restaurantsItem.map((i) => RestaurantListModel.fromJson(i)).toList();

    return RestaurantsSearchResultModel(
      error: json['error'],
      founded: json['founded'],
      restaurant: dataRestaurantsList,
    );
  }
}
