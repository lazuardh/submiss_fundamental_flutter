import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submiss1_fundamental/restaurant/data/api/api_service.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_detail_provider.dart';
import 'package:submiss1_fundamental/restaurant/ui/widgets/connection.dart';

import '../../../../../utils/color.dart';
import '../../../../../utils/fonts_utils.dart';
import '../../../../../utils/size.dart';

class RestaurantDetail extends StatefulWidget {
  final String id;

  const RestaurantDetail({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final List<String> menus = ['Food', 'Drink'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Connection(
      child: ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (context) => RestaurantDetailProvider(
          apiService: ApiService(),
          id: widget.id,
        ),
        child: Consumer<RestaurantDetailProvider>(
          builder: (context, state, child) {
            if (state.state == ResultState.loading) {
              return Container(
                color: Colors.blue,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return Scaffold(
                body: SafeArea(
                  child: ListView(
                    children: [
                      /* app bar */

                      Hero(
                        tag: state.restaurantDetail.restaurant.pictureId,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "https://restaurant-api.dicoding.dev/images/small/${state.restaurantDetail.restaurant.pictureId}",
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text(
                          state.restaurantDetail.restaurant.name,
                          style: AppTextStyle.medium.copyWith(
                            fontSize: AppFontSize.big,
                            color: AppColors.blackPrimary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 15,
                              color: AppColors.greyDarker,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              state.restaurantDetail.restaurant.city,
                              style: AppTextStyle.medium.copyWith(
                                fontSize: AppFontSize.normal,
                                color: AppColors.greyDarker,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'Description',
                          style: AppTextStyle.medium.copyWith(
                            fontSize: AppFontSize.big,
                            color: AppColors.blackPrimary,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          state.restaurantDetail.restaurant.description,
                          style: AppTextStyle.medium.copyWith(
                            fontSize: AppFontSize.normal,
                            color: AppColors.greyDarker,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Menu",
                          style: AppTextStyle.medium.copyWith(
                            fontSize: AppFontSize.big,
                            color: AppColors.blackPrimary,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ...List.generate(menus.length, (index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedIndex = index;
                                      });
                                    },
                                    child: Text(
                                      menus[index],
                                      style: AppTextStyle.medium.copyWith(
                                        fontSize: AppFontSize.medium,
                                        color: selectedIndex == index
                                            ? Colors.amber
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 155,
                                  height: 3,
                                  color: selectedIndex == index
                                      ? Colors.grey
                                      : Colors.transparent,
                                )
                              ],
                            );
                          })
                        ],
                      ),
                      IndexedStack(
                        index: selectedIndex,
                        children: [
                          _buildFoodList(state),
                          _buildDrinksList(state),
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text(''),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildFoodList(RestaurantDetailProvider state) {
    final food = state.restaurantDetail.restaurant.menus.foods;
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runSpacing: 2,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ...List.generate(
                state.restaurantDetail.restaurant.menus.foods.length, (index) {
              return Container(
                width: 160,
                height: 130,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Image.asset(
                          'assets/fast-food.png',
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        food[index].name,
                        style: AppTextStyle.medium.copyWith(
                          fontSize: AppFontSize.normal,
                          color: AppColors.blackPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      child: Text(
                        "IDR 15.000",
                        style: AppTextStyle.medium.copyWith(
                          fontSize: AppFontSize.small,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildDrinksList(RestaurantDetailProvider state) {
    final drink = state.restaurantDetail.restaurant.menus.drinks;
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runSpacing: 2,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ...List.generate(drink.length, (index) {
              return Container(
                width: 160,
                height: 130,
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Image.asset(
                          'assets/fast-food.png',
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        drink[index].name,
                        style: AppTextStyle.medium.copyWith(
                          fontSize: AppFontSize.normal,
                          color: AppColors.blackPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      child: Text(
                        "IDR 15.000",
                        style: AppTextStyle.medium.copyWith(
                          fontSize: AppFontSize.small,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
