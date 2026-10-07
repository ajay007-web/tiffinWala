import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/mock/mock_plans.dart';
import 'plans_state.dart';

class PlansCubit extends Cubit<PlansState> {
  PlansCubit()
      : super(PlansState(
          plans: mockPlans,
          selectedPlanId: 'plan_20',
        ));

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }
}
