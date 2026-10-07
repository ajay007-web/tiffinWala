import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/constants/asset_paths.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/animated_pressable.dart';
import '../../../../core/widgets/custom_svg_icon.dart';

class SubscriptionPromoCard extends StatelessWidget {
  final VoidCallback onTapViewPlans;

  const SubscriptionPromoCard({
    super.key,
    required this.onTapViewPlans,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9F3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFFFEAD6), width: 1.2),
          boxShadow: AppShadows.xs,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Never miss your homemade meal',
                    style: AppTypography.heading3.copyWith(
                      color: AppColors.charcoal900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Subscribe once, enjoy fresh meals daily without daily ordering hassle.',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.charcoal600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedPressable(
                    onTap: onTapViewPlans,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: AppShadows.primary,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View Plans',
                            style: AppTypography.buttonMedium.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            PhosphorIconsRegular.arrowRight,
                            size: 14,
                            color: AppColors.pureWhite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.pureWhite,
                shape: BoxShape.circle,
                boxShadow: AppShadows.xs,
              ),
              child: const Center(
                child: CustomSvgIcon(
                  assetPath: AssetPaths.tiffinBoxSvg,
                  size: 44,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
