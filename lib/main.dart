import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/ui/pages/favorite_pages.dart';
import 'package:submiss1_fundamental/restaurant/ui/pages/settings_page.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_detail_provider.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_provider.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_search_rovider.dart';
import 'package:submiss1_fundamental/restaurant/ui/screen/search_screen.dart';

import 'restaurant/data/db/database_helper.dart';
import 'restaurant/ui/provider/restaurant_favorite.dart';
import 'restaurant/ui/screen/restaurant_detail.dart';
import 'restaurant/ui/screen/restaurant_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FavoriteRestaurantProvider>(
          create: (context) => FavoriteRestaurantProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
          create: (context) => RestaurantProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (context) => RestaurantSearchProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) => RestaurantDetailProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const RestaurantList(),
          '/search': (context) => const SearchScreen(),
          '/favorite': (context) => const FavoritePages(),
          '/settings': (context) => const SettingsPages(),
          '/detailRestaurant': (context) => RestaurantDetail(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
