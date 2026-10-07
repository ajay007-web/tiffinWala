import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/frosted_circle_button.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/veg_badge.dart';
import '../../../data/models/meal_model.dart';
import '../../plans/presentation/plans_screen.dart';

class MealDetailScreen extends StatelessWidget {
  final MealModel meal;

  const MealDetailScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Image Header
              SliverAppBar(
                expandedHeight: 330,
                pinned: true,
                elevation: 0,
                backgroundColor: AppColors.pureWhite,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Center(
                    child: FrostedCircleButton(
                      icon: const Icon(
                        PhosphorIconsRegular.arrowLeft,
                        size: 20,
                        color: AppColors.charcoal900,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: FrostedCircleButton(
                      icon: const Icon(
                        PhosphorIconsRegular.shareNetwork,
                        size: 20,
                        color: AppColors.charcoal900,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Sharing ${meal.shortName}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'meal-image-${meal.id}',
                        child: Image.asset(
                          meal.imageAsset,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Soft gradient overlay
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: AppGradients.imageOverlay,
                          ),
                        ),
                      ),
                      // Veg Badge on hero image
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Row(
                          children: [
                            const VegBadge(),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.charcoal900.withOpacity(0.75),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${meal.dayOfWeek.toUpperCase()}\'S MENU',
                                style: AppTypography.overline.copyWith(
                                  color: AppColors.pureWhite,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Meal Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: AppTypography.heading1.copyWith(
                          fontSize: 22,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        meal.description,
                        style: AppTypography.bodyLarge.copyWith(
                          color: AppColors.charcoal600,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 3 Value Proposition Cards
                      const Row(
                        children: [
                          _FeatureCard(
                            icon: PhosphorIconsRegular.leaf,
                            title: '100% Pure Veg',
                            subtitle: 'Strict hygiene',
                            iconColor: AppColors.success,
                          ),
                          SizedBox(width: 10),
                          _FeatureCard(
                            icon: PhosphorIconsRegular.sparkle,
                            title: 'Freshly Made',
                            subtitle: 'Cooked daily',
                            iconColor: AppColors.warning,
                          ),
                          SizedBox(width: 10),
                          _FeatureCard(
                            icon: PhosphorIconsRegular.house,
                            title: 'Homestyle',
                            subtitle: 'Low oil & spices',
                            iconColor: AppColors.primaryDark,
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // What's Inside
                      Text('What\'s Inside This Thali', style: AppTypography.heading2),
                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.charcoal50,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.charcoal200, width: 1),
                        ),
                        child: Column(
                          children: meal.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: AppTypography.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.charcoal800,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    PhosphorIconsRegular.check,
                                    size: 16,
                                    color: AppColors.success,
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Nutrition Breakdown
                      Text('Nutrition Facts', style: AppTypography.heading2),
                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryUltraLight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryLight.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _NutritionItem(
                              label: 'Calories',
                              value: '${meal.nutrition.calories}',
                              unit: 'kcal',
                              color: AppColors.warning,
                            ),
                            _Divider(),
                            _NutritionItem(
                              label: 'Protein',
                              value: '${meal.nutrition.protein}',
                              unit: 'grams',
                              color: AppColors.primaryDark,
                            ),
                            _Divider(),
                            _NutritionItem(
                              label: 'Carbs',
                              value: '${meal.nutrition.carbs}',
                              unit: 'grams',
                              color: AppColors.info,
                            ),
                            _Divider(),
                            _NutritionItem(
                              label: 'Fats',
                              value: '${meal.nutrition.fat}',
                              unit: 'grams',
                              color: AppColors.charcoal600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Fixed CTA
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: AppShadows.lg,
                border: Border(
                  top: BorderSide(color: AppColors.charcoal100, width: 1),
                ),
              ),
              child: PrimaryButton(
                text: 'Subscribe & Get This Meal',
                prefixIcon: const Icon(
                  PhosphorIconsRegular.calendarPlus,
                  size: 20,
                  color: AppColors.pureWhite,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PlansScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.charcoal50,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.charcoal200, width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, size: 24, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: AppTypography.caption.copyWith(
                fontSize: 10,
                color: AppColors.charcoal600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _NutritionItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _NutritionItem({
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.heading2.copyWith(
            color: color,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          unit,
          style: AppTypography.caption.copyWith(
            fontSize: 10,
            color: AppColors.charcoal400,
          ),
        ),
        const SizedBox(height: 2),
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

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.primaryLight.withOpacity(0.5),
    );
  }
}
