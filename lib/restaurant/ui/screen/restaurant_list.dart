import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submiss1_fundamental/restaurant/ui/provider/restaurant_provider.dart';
import 'package:submiss1_fundamental/restaurant/ui/widgets/connection.dart';
import 'package:submiss1_fundamental/restaurant/ui/widgets/platform_widget.dart';
import 'package:submiss1_fundamental/utils/fonts_utils.dart';
import 'package:submiss1_fundamental/utils/size.dart';

import '../widgets/restaurant_item.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/search'),
                icon: const Icon(Icons.search),
              ),
            ),
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
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, '/search'),
                icon: const Icon(Icons.search),
              ),
            ),
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
      child: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/detailRestaurant',
                  arguments: state.result.restaurants[index].id,
                ),
                child: RestaurantItem(
                  restaurant: state.result.restaurants[index],
                ),
              );
            },
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
    );
  }
}
