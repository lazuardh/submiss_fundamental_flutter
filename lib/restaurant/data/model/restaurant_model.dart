import 'dart:convert';

List<Restaurant> parseRestaurant(String? json) {
  if (json == null) {
    return [];
  }

  final Map<String, dynamic> parsed = jsonDecode(json);
  final List<dynamic> restaurantList = parsed['restaurants'];

  return restaurantList.map((json) => Restaurant.fromJson(json)).toList();
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
        id: restaurant['id'],
        name: restaurant['name'],
        description: restaurant['description'],
        pictureId: restaurant['pictureId'],
        city: restaurant['city'],
        rating: restaurant['rating']?.toDouble(),
        menus: Menus.fromJson(restaurant['menus']),
      );
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> menu) => Menus(
        foods: (menu['foods'] as List<dynamic>)
            .map((foodJson) => Food.fromJson(foodJson))
            .toList(),
        drinks: (menu['drinks'] as List<dynamic>)
            .map((drinkJson) => Drink.fromJson(drinkJson))
            .toList(),
      );
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) => Food(name: json['name']);
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) =>
      Drink(name: json['name']);
}
