import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/meal_model.dart';
import '../../meal_detail/presentation/meal_detail_screen.dart';
import '../../plans/presentation/plans_screen.dart';
import '../../subscription/cubit/subscription_cubit.dart';
import '../../subscription/cubit/subscription_state.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'widgets/active_plan_card.dart';
import 'widgets/greeting_header.dart';
import 'widgets/subscription_promo_card.dart';
import 'widgets/todays_meal_card.dart';
import 'widgets/weekly_preview_section.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onNavigateToMenu;
  final VoidCallback onNavigateToPlans;

  const HomeScreen({
    super.key,
    required this.onNavigateToMenu,
    required this.onNavigateToPlans,
  });

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

  void _openPlans(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PlansScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, homeState) {
            return BlocBuilder<SubscriptionCubit, SubscriptionState>(
              builder: (context, subState) {
                return RefreshIndicator(
                  color: const Color(0xFF87BAAB),
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Greeting & Notification Bell
                        GreetingHeader(
                          userName: homeState.user.name,
                          onNotificationTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Daily meal scheduled for 12:30 PM delivery'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),

                        // Active Plan Progress Card (If active)
                        if (subState.hasActivePlan)
                          ActivePlanCard(
                            subscription: subState.subscription!,
                            onTapViewPlan: onNavigateToPlans,
                          ),

                        // Today's Hero Meal Card
                        TodaysMealCard(
                          meal: homeState.todaysMeal,
                          onTap: () => _openMealDetail(context, homeState.todaysMeal),
                        ),

                        // Weekly Menu Day Selector & Preview
                        WeeklyPreviewSection(
                          meals: homeState.weeklyMeals,
                          selectedDayIndex: homeState.selectedDayIndex,
                          onDaySelected: (idx) {
                            context.read<HomeCubit>().selectDay(idx);
                          },
                          onMealTap: (meal) => _openMealDetail(context, meal),
                        ),

                        // Promotional Subscription CTA Card
                        SubscriptionPromoCard(
                          onTapViewPlans: () => _openPlans(context),
                        ),

                        // Clearance for floating bottom nav bar
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
