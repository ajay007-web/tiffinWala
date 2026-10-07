import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/animated_pressable.dart';
import '../../../../core/widgets/custom_svg_icon.dart';
import '../../../../data/models/subscription_model.dart';

class ActivePlanCard extends StatelessWidget {
  final SubscriptionModel subscription;
  final VoidCallback onTapViewPlan;

  const ActivePlanCard({
    super.key,
    required this.subscription,
    required this.onTapViewPlan,
  });

  @override
  Widget build(BuildContext context) {
    final remaining = subscription.remainingMeals;
    final total = subscription.totalMeals;
    final consumed = subscription.consumedMeals;
    final progress = (total > 0) ? (consumed / total) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppGradients.heroCardGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppShadows.md,
        ),
        child: Stack(
          children: [
            // Background subtle decorative icon
            const Positioned(
              right: -8,
              bottom: -10,
              child: Opacity(
                opacity: 0.15,
                child: CustomSvgIcon(
                  assetPath: AssetPaths.tiffinBoxSvg,
                  size: 110,
                  color: AppColors.pureWhite,
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pureWhite.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'ACTIVE PLAN',
                        style: AppTypography.overline.copyWith(
                          color: AppColors.pureWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          PhosphorIconsRegular.sealCheck,
                          color: AppColors.pureWhite,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.pureWhite.withOpacity(0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  subscription.plan.name,
                  style: AppTypography.heading1.copyWith(
                    color: AppColors.pureWhite,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '$remaining of $total meals remaining',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.pureWhite.withOpacity(0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                // Linear Progress Track
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    height: 7,
                    width: double.infinity,
                    color: AppColors.pureWhite.withOpacity(0.25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progress.clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.pureWhite,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$consumed meals consumed',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.pureWhite.withOpacity(0.75),
                      ),
                    ),
                    AnimatedPressable(
                      onTap: onTapViewPlan,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pureWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Plan',
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
