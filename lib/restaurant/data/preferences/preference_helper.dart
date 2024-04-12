import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const favorite = "Favorites";

  Future<bool> get isFavorite async {
    final prefs = await sharedPreferences;
    return prefs.getBool(favorite) ?? false;
  }

  void setFavorite(bool newValue) async {
    final prefs = await sharedPreferences;
    prefs.setBool(favorite, newValue);
  }
}
