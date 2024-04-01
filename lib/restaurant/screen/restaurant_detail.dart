import 'package:flutter/material.dart';
import 'package:submiss1_fundamental/restaurant/params/restaurant_params.dart';

import '../../utils/color.dart';
import '../../utils/fonts_utils.dart';
import '../../utils/size.dart';

class RestaurantDetail extends StatefulWidget {
  final RestaurantParams data;

  const RestaurantDetail(this.data, {Key? key}) : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  final List<String> menus = ['Food', 'Drink'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            /* app bar */

            Hero(
              tag: widget.data.image,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.data.image,
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
                widget.data.name,
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
                    widget.data.location,
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
                widget.data.description,
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
                _buildFoodList(),
                _buildDrinksList(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFoodList() {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runSpacing: 2,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ...List.generate(widget.data.menu.foods.length, (index) {
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
                        widget.data.menu.foods[index].name,
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

  Widget _buildDrinksList() {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          runSpacing: 2,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ...List.generate(widget.data.menu.drinks.length, (index) {
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
                        widget.data.menu.drinks[index].name,
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
