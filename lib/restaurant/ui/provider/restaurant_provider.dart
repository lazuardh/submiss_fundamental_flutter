import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({
    required this.apiService,
  }) {
    _fetchRestaurant();
  }

  late Restaurant _restaurantResult;
  late ResultState _state;

  String _message = '';

  String get message => _message;
  Restaurant get result => _restaurantResult;

  ResultState get state => _state;

  Future<void> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await apiService.getRestaurant();

      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'error provider => $e';
    }
  }
}
