import 'package:flutter/material.dart';
import 'package:mealmarketapp/theme/theme.dart';

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
