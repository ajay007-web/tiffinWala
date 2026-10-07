import 'package:flutter/material.dart';
import '../constants/asset_paths.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'custom_svg_icon.dart';
import 'primary_button.dart';

class EmptyStateView extends StatelessWidget {
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final String svgAsset;

  const EmptyStateView({
    super.key,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
    this.svgAsset = AssetPaths.emptyPlateSvg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.primaryUltraLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomSvgIcon(
                  assetPath: svgAsset,
                  size: 56,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.heading2,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.charcoal600,
              ),
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 28),
              SizedBox(
                width: 200,
                child: PrimaryButton(
                  text: buttonText!,
                  onPressed: onButtonPressed,
                  height: 48,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
