import 'package:flutter/material.dart';
import 'package:mealmarketapp/ui/widgets/shimmer.dart';

class ShimmerRestaurantList extends StatelessWidget {
  const ShimmerRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 16),
                  child: ShimmerStyle.rectangular(
                    height: 64,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerStyle.rectangular(
                        height: 14,
                        width: 150,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ShimmerStyle.rectangular(
                        height: 12,
                        width: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              child: ShimmerStyle.rectangular(
            height: 100,
            shapeBorder:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          )),
        ],
      ),
    );
  }
}
