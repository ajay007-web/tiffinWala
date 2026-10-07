import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_typography.dart';
import 'animated_pressable.dart';

class DaySelectorPill extends StatelessWidget {
  final String dayShort;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const DaySelectorPill({
    super.key,
    required this.dayShort,
    required this.isSelected,
    this.isToday = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : (isToday ? AppColors.primaryUltraLight : AppColors.charcoal50),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isToday ? AppColors.primaryLight : AppColors.charcoal200),
            width: 1,
          ),
          boxShadow: isSelected ? AppShadows.primary : AppShadows.none,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayShort,
              style: AppTypography.caption.copyWith(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? AppColors.pureWhite
                    : (isToday ? AppColors.primaryDark : AppColors.charcoal600),
              ),
            ),
            if (isToday && !isSelected) ...[
              const SizedBox(width: 4),
              Container(
                width: 5,
                height: 5,
                decoration: const BoxDecoration(
                  color: AppColors.primaryDark,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
