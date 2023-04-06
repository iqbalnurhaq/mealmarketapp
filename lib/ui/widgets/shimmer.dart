import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerStyle extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerStyle.rectangular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(),
  });

  const ShimmerStyle.circular({
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.black.withOpacity(0.3),
        highlightColor: Colors.grey.withOpacity(0.1),
        period: Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey.withOpacity(0.6),
            shape: shapeBorder,
          ),
        ),
      );
}
