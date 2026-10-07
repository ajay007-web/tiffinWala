import 'plan_model.dart';
import 'address_model.dart';

class SubscriptionModel {
  final PlanModel plan;
  final int totalMeals;
  final int consumedMeals;
  final DateTime startDate;
  final DateTime endDate;
  final AddressModel deliveryAddress;
  final bool isActive;
  final List<DateTime> deliveredDates;

  const SubscriptionModel({
    required this.plan,
    required this.totalMeals,
    required this.consumedMeals,
    required this.startDate,
    required this.endDate,
    required this.deliveryAddress,
    this.isActive = true,
    this.deliveredDates = const [],
  });

  int get remainingMeals => totalMeals - consumedMeals;
  double get progress => totalMeals > 0 ? (consumedMeals / totalMeals) : 0.0;

  SubscriptionModel copyWith({
    PlanModel? plan,
    int? totalMeals,
    int? consumedMeals,
    DateTime? startDate,
    DateTime? endDate,
    AddressModel? deliveryAddress,
    bool? isActive,
    List<DateTime>? deliveredDates,
  }) {
    return SubscriptionModel(
      plan: plan ?? this.plan,
      totalMeals: totalMeals ?? this.totalMeals,
      consumedMeals: consumedMeals ?? this.consumedMeals,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      isActive: isActive ?? this.isActive,
      deliveredDates: deliveredDates ?? this.deliveredDates,
    );
  }
}
