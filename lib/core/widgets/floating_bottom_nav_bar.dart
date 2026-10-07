import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../theme/app_colors.dart';
import '../theme/app_shadows.dart';
import '../theme/app_typography.dart';
import 'animated_pressable.dart';

class FloatingBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const FloatingBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: AppShadows.floatingNav,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.pureWhite.withOpacity(0.94),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: AppColors.pureWhite.withOpacity(0.8),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  _NavBarItem(
                    label: 'Home',
                    regularIcon: PhosphorIconsRegular.house,
                    fillIcon: PhosphorIconsFill.house,
                    isSelected: currentIndex == 0,
                    onTap: () => onTabSelected(0),
                  ),
                  _NavBarItem(
                    label: 'Menu',
                    regularIcon: PhosphorIconsRegular.forkKnife,
                    fillIcon: PhosphorIconsFill.forkKnife,
                    isSelected: currentIndex == 1,
                    onTap: () => onTabSelected(1),
                  ),
                  _NavBarItem(
                    label: 'My Plan',
                    regularIcon: PhosphorIconsRegular.calendarCheck,
                    fillIcon: PhosphorIconsFill.calendarCheck,
                    isSelected: currentIndex == 2,
                    onTap: () => onTabSelected(2),
                  ),
                  _NavBarItem(
                    label: 'Profile',
                    regularIcon: PhosphorIconsRegular.userCircle,
                    fillIcon: PhosphorIconsFill.userCircle,
                    isSelected: currentIndex == 3,
                    onTap: () => onTabSelected(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final IconData regularIcon;
  final IconData fillIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.label,
    required this.regularIcon,
    required this.fillIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedPressable(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryUltraLight
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: Tween<double>(begin: 0.85, end: 1.0).animate(
                    CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
                  ),
                  child: child,
                ),
                child: Icon(
                  isSelected ? fillIcon : regularIcon,
                  key: ValueKey(isSelected),
                  size: 22,
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.charcoal400,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  fontSize: 10.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? AppColors.primaryDark
                      : AppColors.charcoal600,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isSelected ? 4 : 0,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
