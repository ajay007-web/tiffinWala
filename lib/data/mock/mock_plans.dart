import '../models/plan_model.dart';

final List<PlanModel> mockPlans = [
  const PlanModel(
    id: 'plan_10',
    name: '10 Meal Plan',
    mealCount: 10,
    pricePerMeal: 120.0,
    subtitle: 'Starter Plan',
    features: [
      '10 wholesome homemade meals',
      'Free daily doorstep delivery',
      'Flexible skip / pause anytime',
      'Valid for 20 calendar days',
      'Zero delivery or packaging charges',
    ],
  ),
  const PlanModel(
    id: 'plan_20',
    name: '20 Meal Plan',
    mealCount: 20,
    pricePerMeal: 120.0,
    badge: 'Most Popular',
    subtitle: 'Recommended Choice',
    features: [
      '20 wholesome homemade meals',
      'Priority delivery time slot',
      'Free doorstep delivery',
      'Skip or reschedule with 1 tap',
      'Valid for 35 calendar days',
      'Special Sunday dessert included',
    ],
  ),
  const PlanModel(
    id: 'plan_30',
    name: '30 Meal Plan',
    mealCount: 30,
    pricePerMeal: 120.0,
    badge: 'Best Value',
    subtitle: 'Best for Monthly',
    features: [
      '30 wholesome homemade meals',
      'Maximum savings & peace of mind',
      'VIP priority delivery & custom slot',
      'Unlimited date pauses & extensions',
      'Valid for 50 calendar days',
      'Dedicated relationship manager',
    ],
  ),
];
