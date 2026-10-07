import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'animated_pressable.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final Color borderColor;
  final Color textColor;

  const OutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height = 48.0,
    this.borderColor = AppColors.primary,
    this.textColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTypography.buttonMedium.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
