import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mealmarketapp/provider/restaurant_provider.dart';
import 'package:mealmarketapp/ui/widgets/home_header.dart';
import 'package:mealmarketapp/ui/widgets/list_restaurant_card.dart';
import 'package:mealmarketapp/ui/widgets/shimmer_restaurant_list.dart';
import 'package:provider/provider.dart';

import '../../theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchAllRestaurant();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: SingleChildScrollView(
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
              child: Consumer<RestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return Column(
                      children: List.generate(10, (index) {
                        return ShimmerRestaurantList();
                      }),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return Column(
                      children: List.generate(
                          state.result?.restaurant.length ?? 0, (index) {
                        return ListRestaurantCard(
                            state.result!.restaurant[index]);
                      }),
                    );
                  } else if (state.state == ResultState.noData) {
                    return Center(
                      child: Material(child: Text(state.message)),
                    );
                  } else if (state.state == ResultState.error) {
                    return Center(
                      child: Material(
                        child: Column(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: SvgPicture.asset(
                                  'assets/icon/ic_not_connect.svg'),
                            ),
                            Text(
                              state.message,
                              style: redTextStyle.copyWith(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Material(child: Text('')),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
