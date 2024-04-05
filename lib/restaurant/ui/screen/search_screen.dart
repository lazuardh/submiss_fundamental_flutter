import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_search.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_search_rovider.dart';
import 'package:submiss1_fundamental/restaurant/ui/widgets/connection.dart';
import 'package:submiss1_fundamental/restaurant/ui/widgets/search.dart';

import '../../../utils/color.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/size.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController search;

  @override
  void initState() {
    super.initState();

    final RestaurantSearchProvider searchRestaurant =
        Provider.of<RestaurantSearchProvider>(context, listen: false);

    search = TextEditingController(text: searchRestaurant.query);
  }

  @override
  Widget build(BuildContext context) {
    return Connection(
      child: Scaffold(
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Search",
                style: AppTextStyle.medium.copyWith(
                  fontSize: AppFontSize.big,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomTextFormFieldSearch(
                controller: search,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();

                  Provider.of<RestaurantSearchProvider>(context, listen: false)
                      .searchRestaurant(value);
                },
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  Provider.of<RestaurantSearchProvider>(context, listen: false)
                      .searchRestaurant(search.text);
                },
              ),
            ),
            Consumer<RestaurantSearchProvider>(
              builder: (context, state, _) {
                if (state.state == ResultState.loading) {
                  return const CircularProgressIndicator();
                  // return FutureBuilder(
                  //   future: Future.delayed(const Duration(seconds: 5)),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return Center(
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: const [
                  //             Icon(Icons.search, size: 40),
                  //             SizedBox(height: 10),
                  //             Text('Finding restaurant for you. Please wait ...')
                  //           ],
                  //         ),
                  //       );
                  //     } else {
                  //       return const SizedBox();
                  //     }
                  //   },
                  // );
                } else if (state.state == ResultState.hasData) {
                  if (state.query.isEmpty) {
                    return const Center(
                      child: Text('Search your Restaurant.'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.restaurantSearch.founded,
                      itemBuilder: (context, index) {
                        return RestaurantSearchItem(
                          restaurant: state.restaurantSearch.restaurants[index],
                        );
                      },
                    ),
                  );
                } else if (state.state == ResultState.noData) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else if (state.state == ResultState.error) {
                  return Center(
                    child: Material(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return const Center(
                    child: Material(
                      child: Text(''),
                    ),
                  );
                }
              },
            )
          ],
        )),
      ),
    );
  }
}

class RestaurantSearchItem extends StatelessWidget {
  final RestaurantSearchElement _restaurant;

  const RestaurantSearchItem({
    Key? key,
    required RestaurantSearchElement restaurant,
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
