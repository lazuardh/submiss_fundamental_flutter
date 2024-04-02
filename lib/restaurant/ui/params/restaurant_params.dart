import '../../data/model/restaurant_model.dart';

class RestaurantParams {
  final String image;
  final String name;
  final String location;
  final String description;
  final double rating;
  final Menus menu;

  RestaurantParams({
    this.image = '',
    this.name = '',
    this.location = '',
    this.description = '',
    this.rating = 0,
    required this.menu,
  });
}
