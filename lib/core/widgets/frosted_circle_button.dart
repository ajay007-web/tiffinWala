import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import 'animated_pressable.dart';

class FrostedCircleButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;
  final double size;

  const FrostedCircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: AppColors.pureWhite.withOpacity(0.85),
              shape: BoxShape.circle,
              boxShadow: AppShadows.sm,
              border: Border.all(
                color: AppColors.pureWhite.withOpacity(0.6),
                width: 1,
              ),
            ),
            child: Center(child: icon),
          ),
        ),
      ),
    );
  }
}
