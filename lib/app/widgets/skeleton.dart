import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLong extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  const SkeletonLong({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          color: Colors.white,
        ),
        width: width,
        height: height,
      ),
    );
  }
}

class SkeletonCircle extends StatelessWidget {
  final double height;
  final double width;
  const SkeletonCircle({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.white,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
