import 'package:flutter/material.dart';
import 'package:mealmarketapp/data/api/api_service.dart';
import 'package:mealmarketapp/data/model/restaurant_detail_model.dart';
import 'package:mealmarketapp/data/model/restaurants_list_model.dart';
import 'package:mealmarketapp/data/model/restaurants_search_model.dart';

enum ResultState { idle, loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  RestaurantsListResultModel? _restaurantsResult;
  RestaurantsSearchResultModel? _serachRestaurantsResult;
  RestaurantDetailResultModel? _restaurantDetailResult;
  ResultState _state = ResultState.idle;
  String _message = '';

  ResultState get state => _state;
  String get message => _message;

  ResultState _searchState = ResultState.idle;
  String _searchMessage = '';

  ResultState get searchState => _searchState;
  String get searchMessage => _searchMessage;

  RestaurantsListResultModel? get result => _restaurantsResult;
  RestaurantsSearchResultModel? get searchResult => _serachRestaurantsResult;
  RestaurantDetailResultModel? get detailResult => _restaurantDetailResult;

  void removeSearch() {
    _serachRestaurantsResult = null;
    _searchState = ResultState.idle;
  }

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().restaurantsListApi();
      if (restaurant.restaurant.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      bool internetCheck = e.toString().contains('Failed host lookup');
      if (internetCheck) {
        return _message = 'No Internet Connection, Please Check Again!';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }

  Future<dynamic> searchRestaurant(String search) async {
    try {
      _searchState = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().searchRestaurantsApi(search);

      if (restaurant.restaurant.isEmpty) {
        _searchState = ResultState.noData;
        notifyListeners();
        return _searchMessage = 'Empty Data';
      } else {
        _searchState = ResultState.hasData;
        notifyListeners();
        return _serachRestaurantsResult = restaurant;
      }
    } catch (e) {
      _searchState = ResultState.error;
      notifyListeners();
      bool internetCheck = e.toString().contains('Failed host lookup');
      if (internetCheck) {
        return _searchMessage = 'No Internet Connection, Please Check Again!';
      } else {
        return _searchMessage = 'Error --> $e';
      }
    }
  }

  Future<dynamic> restaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await ApiService().restaurantDetailApi(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetailResult = restaurant;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      bool internetCheck = e.toString().contains('Failed host lookup');
      if (internetCheck) {
        return _message = 'No Internet Connection, Please Check Again!';
      } else {
        return _message = 'Error --> $e';
      }
    }
  }
}
