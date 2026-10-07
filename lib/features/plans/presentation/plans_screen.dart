import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/price_utils.dart';
import '../../../core/widgets/animated_pressable.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/plan_model.dart';
import '../../checkout/presentation/checkout_screen.dart';
import '../cubit/plans_cubit.dart';
import '../cubit/plans_state.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        title: Text('Choose Your Plan', style: AppTypography.heading2),
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft, color: AppColors.charcoal900),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<PlansCubit, PlansState>(
        builder: (context, state) {
          final selectedPlan = state.selectedPlan;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'More meals, more savings.',
                        style: AppTypography.heading3.copyWith(
                          color: AppColors.charcoal900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All subscriptions include free daily contactless delivery, pause anytime option, and fresh homemade recipes.',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.charcoal600,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Pricing Cards
                      ...state.plans.map((plan) {
                        final isSelected = plan.id == state.selectedPlanId;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _PlanCard(
                            plan: plan,
                            isSelected: isSelected,
                            onTap: () {
                              context.read<PlansCubit>().selectPlan(plan.id);
                            },
                          ),
                        );
                      }),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Action Bar
              Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                decoration: const BoxDecoration(
                  color: AppColors.pureWhite,
                  boxShadow: AppShadows.lg,
                  border: Border(
                    top: BorderSide(color: AppColors.charcoal100, width: 1),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedPlan.name,
                              style: AppTypography.caption.copyWith(
                                color: AppColors.charcoal600,
                              ),
                            ),
                            Text(
                              PriceUtils.format(selectedPlan.total),
                              style: AppTypography.priceDisplay.copyWith(fontSize: 24),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 180,
                          child: PrimaryButton(
                            text: 'Continue',
                            suffixIcon: const Icon(
                              PhosphorIconsRegular.arrowRight,
                              size: 16,
                              color: AppColors.pureWhite,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CheckoutScreen(plan: selectedPlan),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PlanModel plan;
  final bool isSelected;
  final VoidCallback onTap;

  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      scaleAmount: 0.98,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.charcoal200,
            width: isSelected ? 2.2 : 1.2,
          ),
          boxShadow: isSelected ? AppShadows.primary : AppShadows.xs,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.charcoal400,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              PhosphorIconsBold.check,
                              size: 13,
                              color: AppColors.pureWhite,
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Text(plan.name, style: AppTypography.heading2),
                  ],
                ),
                if (plan.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      plan.badge!,
                      style: AppTypography.overline.copyWith(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Price & breakdown
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  PriceUtils.format(plan.total),
                  style: AppTypography.priceDisplay,
                ),
                const SizedBox(width: 8),
                Text(
                  '(${PriceUtils.format(plan.pricePerMeal)} / meal)',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.charcoal600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Divider
            const Divider(),

            const SizedBox(height: 14),

            // Features Checklist
            Column(
              children: plan.features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        PhosphorIconsFill.checkCircle,
                        size: 16,
                        color: AppColors.success,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.charcoal800,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
