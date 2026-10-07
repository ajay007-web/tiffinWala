import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/animated_pressable.dart';
import '../../../core/widgets/veg_badge.dart';
import '../../../data/mock/mock_meals.dart';
import '../../../data/models/meal_model.dart';
import '../../meal_detail/presentation/meal_detail_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _openMealDetail(BuildContext context, MealModel meal) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 350),
        pageBuilder: (_, __, ___) => MealDetailScreen(meal: meal),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayWeekday = DateTime.now().weekday - 1; // 0=Mon, 6=Sun

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // App Bar Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weekly Menu', style: AppTypography.displayMedium),
                    const SizedBox(height: 4),
                    Text(
                      'Freshly prepared meals, planned for your entire week.',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.charcoal600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Daily Meal Cards List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final meal = mockWeeklyMeals[index];
                    final isToday = index == todayWeekday;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _DailyMenuCard(
                        meal: meal,
                        isToday: isToday,
                        onTap: () => _openMealDetail(context, meal),
                      ),
                    );
                  },
                  childCount: mockWeeklyMeals.length,
                ),
              ),
            ),

            // Bottom clearance for floating nav
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyMenuCard extends StatelessWidget {
  final MealModel meal;
  final bool isToday;
  final VoidCallback onTap;

  const _DailyMenuCard({
    required this.meal,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isToday ? AppColors.primary : AppColors.charcoal100,
            width: isToday ? 1.8 : 1,
          ),
          boxShadow: isToday ? AppShadows.md : AppShadows.xs,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Overlays
            Stack(
              children: [
                Hero(
                  tag: 'meal-image-${meal.id}',
                  child: Image.asset(
                    meal.imageAsset,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // Top day badge
                Positioned(
                  top: 14,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: isToday
                          ? AppColors.primary
                          : AppColors.charcoal900.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          meal.dayOfWeek.toUpperCase(),
                          style: AppTypography.overline.copyWith(
                            color: AppColors.pureWhite,
                            letterSpacing: 1.2,
                          ),
                        ),
                        if (isToday) ...[
                          const SizedBox(width: 4),
                          const Text('• TODAY', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ],
                    ),
                  ),
                ),

                // Veg Badge & Special Badge
                Positioned(
                  top: 14,
                  right: 14,
                  child: Row(
                    children: [
                      if (meal.specialBadge != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            meal.specialBadge!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                      ],
                      const VegBadge(compact: true),
                    ],
                  ),
                ),
              ],
            ),

            // Card Body
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: AppTypography.heading3.copyWith(fontSize: 17),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    meal.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.charcoal600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 12),

                  // Ingredients Chips
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: meal.items.map((item) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.charcoal50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.charcoal200,
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          item,
                          style: AppTypography.caption.copyWith(
                            fontSize: 11,
                            color: AppColors.charcoal800,
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 14),

                  // Bottom info & CTA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            PhosphorIconsRegular.fire,
                            size: 15,
                            color: AppColors.warning,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${meal.calories} kcal',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Icon(
                            PhosphorIconsRegular.clock,
                            size: 15,
                            color: AppColors.primaryDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            meal.deliveryTime.split(' - ')[0],
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'View Details',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            PhosphorIconsRegular.arrowRight,
                            size: 14,
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
    );
  }
}
