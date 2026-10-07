import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/animated_pressable.dart';
import '../../../../core/widgets/veg_badge.dart';
import '../../../../data/models/meal_model.dart';

class TodaysMealCard extends StatelessWidget {
  final MealModel meal;
  final VoidCallback onTap;

  const TodaysMealCard({
    super.key,
    required this.meal,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: AnimatedPressable(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20),
            boxShadow: AppShadows.cardElevated,
            border: Border.all(color: AppColors.charcoal100, width: 1),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Food Image with Overlay
              Stack(
                children: [
                  Hero(
                    tag: 'meal-image-${meal.id}',
                    child: Image.asset(
                      meal.imageAsset,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: AppColors.primaryUltraLight,
                        child: const Center(
                          child: Icon(
                            PhosphorIconsRegular.bowlFood,
                            size: 48,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Gradient Dark Overlay at bottom of image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppGradients.imageOverlay,
                      ),
                    ),
                  ),

                  // Top Badges
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.charcoal900.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'TODAY\'S MEAL',
                        style: AppTypography.overline.copyWith(
                          color: AppColors.pureWhite,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const Positioned(
                    top: 14,
                    right: 14,
                    child: VegBadge(),
                  ),

                  // Date label on bottom of image
                  Positioned(
                    bottom: 12,
                    left: 14,
                    child: Row(
                      children: [
                        const Icon(
                          PhosphorIconsRegular.calendar,
                          size: 15,
                          color: AppColors.pureWhite,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppDateUtils.getTodayFormatted(),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.pureWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Meal Content Details
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: AppTypography.heading2.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    // Quick metadata chips
                    Row(
                      children: [
                        _MetaChip(
                          icon: PhosphorIconsRegular.clock,
                          label: meal.deliveryTime.split(' - ')[0],
                          color: AppColors.primaryDark,
                        ),
                        const SizedBox(width: 12),
                        _MetaChip(
                          icon: PhosphorIconsRegular.fire,
                          label: '${meal.calories} kcal',
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: 12),
                        const _MetaChip(
                          icon: PhosphorIconsRegular.package,
                          label: 'Full Thali',
                          color: AppColors.charcoal600,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // CTA row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'View today\'s menu items',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'View Details',
                              style: AppTypography.buttonMedium.copyWith(
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              PhosphorIconsRegular.arrowRight,
                              size: 16,
                              color: AppColors.primaryDark,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal800,
          ),
        ),
      ],
    );
  }
}
