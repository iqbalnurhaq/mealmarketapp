import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmarketapp/provider/restaurant_provider.dart';
import 'package:mealmarketapp/theme/theme.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  final double topPadding;
  const HomeHeader({super.key, this.topPadding = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 20,
        left: 16,
        right: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .removeSearch();
                  Navigator.pushNamed(context, '/search');
                },
                child: Container(
                  child: SvgPicture.asset(
                    'assets/icon/ic_search.svg',
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Meal Market',
            style: greenTextStyle.copyWith(
              fontSize: 24,
              fontWeight: semiBold,
            ),
          ),
          Text(
            'Choose your restaurant',
            style: grayTextStyle.copyWith(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
