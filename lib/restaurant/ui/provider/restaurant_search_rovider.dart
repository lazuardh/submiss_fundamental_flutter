import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  RestaurantSearchProvider({
    required this.apiService,
    this.query = '',
  }) {
    _getSearchData(query);
  }

  late RestaurantSearch _restaurantSearch;
  late ResultState _state;

  String _message = '';

  String get message => _message;
  RestaurantSearch get restaurantSearch => _restaurantSearch;

  ResultState get state => _state;

  searchRestaurant(String newValue) {
    query = newValue;
    _getSearchData(query);
    notifyListeners();
  }

  Future<void> _getSearchData(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.getRestaurantBySearch(query);

      if (response.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Data Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantSearch = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'error search => $e';
    }
  }
}
