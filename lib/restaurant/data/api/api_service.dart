import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:submiss1_fundamental/restaurant/data/api/constant_url.dart';
import 'package:submiss1_fundamental/restaurant/data/model/detail_restaurant.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_search.dart';

class ApiService {
  Future<Restaurant> getRestaurant() async {
    final response = await http.get(Uri.parse(BaseUrl.listRestaurant));

    if (response.statusCode == 200) {
      return Restaurant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Data Restaurant');
    }
  }

  Future<RestaurantSearch> getRestaurantBySearch(String query) async {
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Detail Data');
    }
  }

  Future<RestaurantDetail> getRestaurantById(String id) async {
    final response =
        await http.get(Uri.parse('${BaseUrl.detailRestaurant}/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Detail Data');
    }
  }
}
