import 'package:flutter/foundation.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/data/db/database_helper.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

enum FavoriteState { loading, noData, hasData, error }

class FavoriteRestaurantProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  FavoriteRestaurantProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  late FavoriteState _state;
  FavoriteState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantElement> _favorite = [];
  List<RestaurantElement> get favorite => _favorite;

  void refreshFavorite() async {
    _state = FavoriteState.loading;
    notifyListeners();

    _getFavorite();
  }

  void _getFavorite() async {
    _state = FavoriteState.loading;
    notifyListeners();

    _favorite = await databaseHelper.getFavoriteRestaurant();

    if (_favorite.isNotEmpty) {
      _state = FavoriteState.hasData;
    } else {
      _state = FavoriteState.noData;
      _message = 'Empty Data favorite';
    }

    notifyListeners();
  }

  void addFavorite(String id) async {
    _state = FavoriteState.loading;
    notifyListeners();

    try {
      final Restaurant getRestaurantId = await ApiService().getRestaurant();

      final RestaurantElement restaurant =
          getRestaurantId.restaurants.firstWhere(
        (element) => element.id == id,
        orElse: () => throw Exception('Restaurant with ID $id not found'),
      );

      final favorite = RestaurantElement(
        id: id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating,
      );

      await databaseHelper.insertFavorite(favorite);
      _getFavorite();
    } catch (e) {
      _state = FavoriteState.error;
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
    _state = FavoriteState.loading;
    notifyListeners();

    try {
      await databaseHelper.removeFavoriteRestaurant(id);
      _getFavorite();
    } catch (e) {
      _state = FavoriteState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
