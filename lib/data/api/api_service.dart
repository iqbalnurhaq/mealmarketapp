import 'package:mealmarketapp/data/model/restaurant_detail_model.dart';
import 'package:mealmarketapp/data/model/restaurants_list_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/restaurants_search_model.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantsListResultModel> restaurantsListApi() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantsListResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load list restaurant, please check again or contact developer');
    }
  }

  Future<RestaurantDetailResultModel> restaurantDetailApi(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load list restaurant, please check again or contact developer');
    }
  }

  Future<RestaurantsSearchResultModel> searchRestaurantsApi(
      String search) async {
    final response = await http.get(Uri.parse("${_baseUrl}search?q=$search"));
    if (response.statusCode == 200) {
      return RestaurantsSearchResultModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load list restaurant, please check again or contact developer');
    }
  }
}
