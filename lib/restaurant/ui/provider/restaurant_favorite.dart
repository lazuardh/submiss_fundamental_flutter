import 'package:flutter/foundation.dart';
import 'package:submiss1_fundamental/restaurant/data/preferences/preference_helper.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  FavoriteRestaurantProvider({required this.preferencesHelper}) {
    _getFavoriteItem();
  }

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  void _getFavoriteItem() async {
    _isFavorite = await preferencesHelper.isFavorite;
    notifyListeners();
  }

  void enableFavoriteItem(bool value) {
    preferencesHelper.setFavorite(value);
    _getFavoriteItem();
  }
}
