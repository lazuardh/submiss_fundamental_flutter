import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submiss1_fundamental/restaurant/data/model/restaurant_model.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_favorite.dart';

import '../../../utils/color.dart';
import '../../../utils/fonts_utils.dart';
import '../../../utils/size.dart';
import '../widgets/connection.dart';
import '../widgets/platform_widget.dart';

class FavoritePages extends StatefulWidget {
  const FavoritePages({super.key});

  @override
  State<FavoritePages> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<FavoritePages> {
  @override
  Widget build(BuildContext context) {
    return Connection(
      child: PlatformWidget(
        androidBuilder: _buildAndroid,
        iosBuilder: _buildIos,
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
            ),
            Text(
              "Restaurant",
              style: AppTextStyle.medium.copyWith(
                fontSize: AppFontSize.big,
              ),
            ),
          ],
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        middle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/search'),
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Text(
              "Restaurant",
              style: AppTextStyle.medium.copyWith(
                fontSize: AppFontSize.big,
              ),
            ),
          ],
        ),
      ),
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      semanticsLabel: 'REFRESH DATA',
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        Provider.of<FavoriteRestaurantProvider>(context, listen: false)
            .refreshFavorite();
      },
      child: Consumer<FavoriteRestaurantProvider>(
        builder: (context, provider, child) {
          if (provider.state == FavoriteState.hasData) {
            return ListView.builder(
              itemCount: provider.favorite.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/detailRestaurant',
                    arguments: provider.favorite[index].id,
                  ),
                  child: FavoriteItem(restaurant: provider.favorite[index]),
                );
              },
            );
          } else {
            return Center(
              child: Material(
                child: Text(provider.message),
              ),
            );
          }
        },
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final RestaurantElement _restaurant;

  const FavoriteItem({
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
