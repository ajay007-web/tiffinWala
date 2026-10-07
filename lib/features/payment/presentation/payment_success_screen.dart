import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/custom_svg_icon.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/plan_model.dart';
import '../../navigation/main_navigation_screen.dart';
import '../../subscription/cubit/subscription_cubit.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final PlanModel plan;
  final AddressModel address;

  const PaymentSuccessScreen({
    super.key,
    required this.plan,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final startDate = DateTime.now();
    final endDate = DateTime.now().add(Duration(days: plan.mealCount + 10));

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Success Checkmark
              Container(
                width: 104,
                height: 104,
                decoration: const BoxDecoration(
                  color: AppColors.successLight,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: CustomSvgIcon(
                    assetPath: AssetPaths.successCheckSvg,
                    size: 72,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                'Your Tiffin Plan is Active! 🎉',
                style: AppTypography.displayMedium.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                '${plan.mealCount} delicious home-style meals are on their way to you.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.charcoal600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Plan Summary Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primaryUltraLight,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryLight.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subscription Plan',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                        Text(
                          plan.name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Starts On',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                        Text(
                          AppDateUtils.formatDate(startDate),
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Valid Till',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                        Text(
                          AppDateUtils.formatDate(endDate),
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              PrimaryButton(
                text: 'View My Plan',
                onPressed: () {
                  // Activate plan in state
                  context.read<SubscriptionCubit>().activatePlan(plan, address);

                  // Navigate to My Plan tab (index 2)
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const MainNavigationScreen(initialIndex: 2),
                    ),
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  context.read<SubscriptionCubit>().activatePlan(plan, address);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const MainNavigationScreen(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Go to Home',
                  style: AppTypography.buttonMedium.copyWith(
                    color: AppColors.charcoal600,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
