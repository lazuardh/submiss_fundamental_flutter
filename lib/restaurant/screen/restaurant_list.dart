import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/model/restaurant_model.dart';
import 'package:submiss1_fundamental/restaurant/params/restaurant_params.dart';
import 'package:submiss1_fundamental/utils/color.dart';
import 'package:submiss1_fundamental/utils/fonts_utils.dart';
import 'package:submiss1_fundamental/utils/size.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Restaurant",
              style: AppTextStyle.medium.copyWith(
                fontSize: AppFontSize.big,
              ),
            ),
            Text(
              "Recomendation restaurant for you!",
              style: AppTextStyle.medium.copyWith(
                fontSize: AppFontSize.medium,
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<String>(
        future:
            DefaultAssetBundle.of(context).loadString('assets/restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurant(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/detailRestaurant',
                    arguments: RestaurantParams(
                      image: restaurants[index].pictureId,
                      name: restaurants[index].name,
                      location: restaurants[index].city,
                      rating: restaurants[index].rating,
                      description: restaurants[index].description,
                      menu: restaurants[index].menus,
                    ),
                  );
                },
                child: _buildRestaurantItem(context, restaurants[index]),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                restaurant.pictureId,
                width: 90,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: AppTextStyle.medium.copyWith(
                  fontSize: AppFontSize.large,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 15,
                    color: AppColors.greyDarker,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    restaurant.city,
                    style: AppTextStyle.medium.copyWith(
                      fontSize: AppFontSize.normal,
                      color: AppColors.greyDarker,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    restaurant.rating.toString(),
                    style: AppTextStyle.medium.copyWith(
                      fontSize: AppFontSize.normal,
                      color: AppColors.greyDarker,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
