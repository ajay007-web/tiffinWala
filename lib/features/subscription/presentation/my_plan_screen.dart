import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradients.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/animated_pressable.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../data/models/subscription_model.dart';
import '../../plans/presentation/plans_screen.dart';
import '../cubit/subscription_cubit.dart';
import '../cubit/subscription_state.dart';

class MyPlanScreen extends StatelessWidget {
  const MyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<SubscriptionCubit, SubscriptionState>(
          builder: (context, state) {
            if (!state.hasActivePlan) {
              return EmptyStateView(
                title: 'No Active Subscription',
                description:
                    'You do not have an active tiffin subscription yet. Choose a plan to enjoy fresh homemade meals every day!',
                buttonText: 'Browse Plans',
                svgAsset: AssetPaths.emptyPlateSvg,
                onButtonPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PlansScreen()),
                  );
                },
              );
            }

            final sub = state.subscription!;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Plan', style: AppTypography.displayMedium),
                  const SizedBox(height: 4),
                  Text(
                    'Track meals, delivery schedule & calendar.',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.charcoal600,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Circular Progress & Stats Hero Card
                  _PlanHeroProgressCard(subscription: sub),

                  const SizedBox(height: 24),

                  // Delivery Calendar
                  _MealCalendarSection(subscription: sub),

                  const SizedBox(height: 24),

                  // Delivery Address Info
                  _DeliveryAddressSection(subscription: sub),

                  const SizedBox(height: 24),

                  // Plan Modification Actions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.charcoal200, width: 1),
                      boxShadow: AppShadows.xs,
                    ),
                    child: Column(
                      children: [
                        _ActionRow(
                          icon: PhosphorIconsRegular.pauseCircle,
                          title: 'Pause Next Delivery',
                          subtitle: 'Going away? Pause without losing meals',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Delivery paused for tomorrow. Meal credited.'),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 20),
                        _ActionRow(
                          icon: PhosphorIconsRegular.plusCircle,
                          title: 'Renew or Upgrade Plan',
                          subtitle: 'Add more meals with volume discounts',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const PlansScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 110),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PlanHeroProgressCard extends StatelessWidget {
  final SubscriptionModel subscription;

  const _PlanHeroProgressCard({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final remaining = subscription.remainingMeals;
    final total = subscription.totalMeals;
    final consumed = subscription.consumedMeals;
    final percentage = (total > 0 ? (consumed / total) * 100 : 0).toInt();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.heroCardGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppShadows.md,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'ACTIVE SUBSCRIPTION',
                      style: AppTypography.overline.copyWith(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subscription.plan.name,
                    style: AppTypography.heading1.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$remaining Meals Left',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Central Circular Progress Indicator
          Center(
            child: SizedBox(
              width: 130,
              height: 130,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: (total > 0 ? (consumed / total) : 0.0).clamp(0.0, 1.0),
                    strokeWidth: 9,
                    backgroundColor: AppColors.pureWhite.withOpacity(0.25),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.pureWhite),
                    strokeCap: StrokeCap.round,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$remaining',
                        style: AppTypography.displayLarge.copyWith(
                          color: AppColors.pureWhite,
                          fontSize: 34,
                        ),
                      ),
                      Text(
                        'remaining',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.pureWhite.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // 3 Columns Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatColumn(label: 'Consumed', value: '$consumed'),
              Container(width: 1, height: 32, color: AppColors.pureWhite.withOpacity(0.3)),
              _StatColumn(label: 'Remaining', value: '$remaining'),
              Container(width: 1, height: 32, color: AppColors.pureWhite.withOpacity(0.3)),
              _StatColumn(label: 'Progress', value: '$percentage%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.heading2.copyWith(
            color: AppColors.pureWhite,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: AppColors.pureWhite.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _MealCalendarSection extends StatelessWidget {
  final SubscriptionModel subscription;

  const _MealCalendarSection({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final currentDay = now.day;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.charcoal200, width: 1),
        boxShadow: AppShadows.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Meal Calendar', style: AppTypography.heading3),
              Text(
                DateFormat('MMMM yyyy').format(now),
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.charcoal600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Days of Week Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
              return SizedBox(
                width: 36,
                child: Center(
                  child: Text(
                    day,
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.charcoal400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),

          // Calendar Grid representation (last 2 weeks to next 2 weeks)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(daysInMonth, (i) {
              final dayNum = i + 1;
              final isDelivered = dayNum < currentDay && dayNum >= (currentDay - 8);
              final isToday = dayNum == currentDay;
              final isUpcoming = dayNum > currentDay && dayNum <= (currentDay + 12);

              Color bgColor = Colors.transparent;
              Color textColor = AppColors.charcoal400;
              Border? border;

              if (isDelivered) {
                bgColor = AppColors.successLight;
                textColor = AppColors.success;
              } else if (isToday) {
                bgColor = AppColors.primary;
                textColor = AppColors.pureWhite;
              } else if (isUpcoming) {
                border = Border.all(color: AppColors.primary, width: 1);
                textColor = AppColors.primaryDark;
              }

              return Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: border,
                ),
                child: Center(
                  child: isDelivered
                      ? const Icon(
                          PhosphorIconsFill.check,
                          size: 14,
                          color: AppColors.success,
                        )
                      : Text(
                          '$dayNum',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isToday ? FontWeight.w700 : FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                ),
              );
            }),
          ),

          const SizedBox(height: 14),

          // Legend
          const Row(
            children: [
              _LegendItem(color: AppColors.successLight, label: 'Delivered'),
              SizedBox(width: 14),
              _LegendItem(color: AppColors.primary, label: 'Today'),
              SizedBox(width: 14),
              _LegendItem(
                color: Colors.transparent,
                borderColor: AppColors.primary,
                label: 'Upcoming',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final String label;

  const _LegendItem({
    required this.color,
    this.borderColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
            border: borderColor != null ? Border.all(color: borderColor!) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            fontSize: 11,
            color: AppColors.charcoal600,
          ),
        ),
      ],
    );
  }
}

class _DeliveryAddressSection extends StatelessWidget {
  final SubscriptionModel subscription;

  const _DeliveryAddressSection({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final addr = subscription.deliveryAddress;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.charcoal200, width: 1),
        boxShadow: AppShadows.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Details', style: AppTypography.heading3),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryUltraLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '12:30 PM SLOT',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                PhosphorIconsRegular.mapPin,
                size: 20,
                color: AppColors.primaryDark,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  addr.formattedAddress,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.charcoal800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryUltraLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryDark, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700)),
                Text(subtitle, style: AppTypography.caption.copyWith(color: AppColors.charcoal600)),
              ],
            ),
          ),
          const Icon(PhosphorIconsRegular.caretRight, size: 16, color: AppColors.charcoal400),
        ],
      ),
    );
  }
}
