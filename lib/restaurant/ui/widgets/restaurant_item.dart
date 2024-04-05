import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';

import '../../../utils/color.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/size.dart';

class RestaurantItem extends StatelessWidget {
  final RestaurantElement _restaurant;

  const RestaurantItem({
    Key? key,
    required RestaurantElement restaurant,
  })  : _restaurant = restaurant,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: _restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/${_restaurant.pictureId}",
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
                _restaurant.name,
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
                    _restaurant.city,
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
                    _restaurant.rating.toString(),
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
