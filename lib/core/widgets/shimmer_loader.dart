import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final ShapeBorder? customShape;

  const ShimmerLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12.0,
    this.customShape,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.charcoal100,
      highlightColor: AppColors.pureWhite.withOpacity(0.8),
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: customShape != null
            ? ShapeDecoration(shape: customShape!, color: AppColors.charcoal100)
            : BoxDecoration(
                color: AppColors.charcoal100,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
      ),
    );
  }
}
