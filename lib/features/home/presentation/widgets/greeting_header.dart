import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/date_utils.dart';

class GreetingHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const GreetingHeader({
    super.key,
    this.userName = 'Ajay',
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppDateUtils.getGreeting(userName),
                  style: AppTypography.heading1.copyWith(
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fresh meals are waiting for you.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.charcoal600,
                  ),
                ),
              ],
            ),
          ),
          // Notification Bell
          GestureDetector(
            onTap: onNotificationTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.charcoal200, width: 1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    PhosphorIconsRegular.bell,
                    size: 22,
                    color: AppColors.charcoal900,
                  ),
                  Positioned(
                    top: 10,
                    right: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
