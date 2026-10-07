import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/mock/mock_user.dart';
import '../../../data/models/subscription_model.dart';
import '../../../data/models/plan_model.dart';
import '../../../data/models/address_model.dart';
import 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit()
      : super(SubscriptionState(subscription: mockActiveSubscription));

  void activatePlan(PlanModel plan, AddressModel address) {
    final newSub = SubscriptionModel(
      plan: plan,
      totalMeals: plan.mealCount,
      consumedMeals: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(days: plan.mealCount + 10)),
      deliveryAddress: address,
      isActive: true,
      deliveredDates: const [],
    );
    emit(state.copyWith(subscription: newSub));
  }

  void cancelSubscription() {
    emit(state.copyWith(clearSubscription: true));
  }
}
