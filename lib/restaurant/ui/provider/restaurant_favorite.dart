import 'package:flutter/foundation.dart';
import 'package:submiss1_fundamental/restaurant/data/db/database_helper.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

enum ResultState { loading, noData, hasData, error }

class FavoriteRestaurantProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteRestaurantProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorite = [];
  List<Restaurant> get favorite => _favorite;

  void _getFavorite() async {
    _favorite = await databaseHelper.getFavoriteRestaurant();
    if (_favorite.length > 0) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data favorite';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error menambah data : $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant =
        await databaseHelper.getFavoriteRestaurantById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeBookmark(String id) async {
    try {
      await databaseHelper.removeFavoriteRestaurant(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
