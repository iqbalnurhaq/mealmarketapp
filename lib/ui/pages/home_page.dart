import 'package:flutter/material.dart';
import 'package:mealmarketapp/model/restaurant.dart';
import 'package:mealmarketapp/ui/widgets/home_header.dart';
import 'package:mealmarketapp/ui/widgets/list_restaurant_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, sanpshot) {
          final List<Restaurant> restaurants = parseRestaurants(sanpshot.data);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(topPadding: topPadding),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: bottomPadding + 20,
                  ),
                  child: Column(
                    children: List.generate(restaurants.length, (index) {
                      return ListRestaurantCard(restaurants[index]);
                    }),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
