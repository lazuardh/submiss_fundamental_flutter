import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/data/model/detail_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  String id;
  int selectedIndex = 0;

  RestaurantDetailProvider({
    required this.apiService,
    this.id = '',
  }) {
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;

  String _message = '';
  String get message => _message;

  RestaurantDetail get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> _fetchRestaurantDetail(id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final response = await apiService.getRestaurantById(id);

      if (response.restaurant.toJson().isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Data Not Found';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantDetail = response;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      print(e);

      _message = 'error error detail => $e';
    }
  }
}
