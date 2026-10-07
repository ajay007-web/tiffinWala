import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/animated_pressable.dart';
import '../../../../core/widgets/day_selector_pill.dart';
import '../../../../core/widgets/veg_badge.dart';
import '../../../../data/models/meal_model.dart';

class WeeklyPreviewSection extends StatelessWidget {
  final List<MealModel> meals;
  final int selectedDayIndex;
  final ValueChanged<int> onDaySelected;
  final ValueChanged<MealModel> onMealTap;

  const WeeklyPreviewSection({
    super.key,
    required this.meals,
    required this.selectedDayIndex,
    required this.onDaySelected,
    required this.onMealTap,
  });

  @override
  Widget build(BuildContext context) {
    final selectedMeal = meals[selectedDayIndex];
    final todayWeekday = DateTime.now().weekday - 1; // 0=Mon, 6=Sun

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('This Week\'s Menu', style: AppTypography.heading2),
                    const SizedBox(height: 2),
                    Text(
                      'Fresh curated homemade recipes',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
                Text(
                  'Mon - Sun',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // Horizontal Day Selector
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: meals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final meal = meals[index];
                return DaySelectorPill(
                  dayShort: meal.dayShort,
                  isSelected: selectedDayIndex == index,
                  isToday: todayWeekday == index,
                  onTap: () => onDaySelected(index),
                );
              },
            ),
          ),

          const SizedBox(height: 14),

          // Animated Day Meal Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.04, 0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                  child: child,
                ),
              ),
              child: AnimatedPressable(
                key: ValueKey(selectedMeal.id),
                onTap: () => onMealTap(selectedMeal),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.charcoal100, width: 1),
                    boxShadow: AppShadows.xs,
                  ),
                  child: Row(
                    children: [
                      // Meal Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          selectedMeal.imageAsset,
                          width: 84,
                          height: 84,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Meal Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  selectedMeal.dayOfWeek.toUpperCase(),
                                  style: AppTypography.overline.copyWith(
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const Spacer(),
                                const VegBadge(compact: true),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedMeal.shortName,
                              style: AppTypography.heading3.copyWith(fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              selectedMeal.items.take(3).join(' • '),
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.charcoal600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  '${selectedMeal.calories} kcal',
                                  style: AppTypography.caption.copyWith(
                                    color: AppColors.warning,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      'View Meal',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      PhosphorIconsRegular.caretRight,
                                      size: 13,
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
            ),
          ),
        ],
      ),
    );
  }
}
