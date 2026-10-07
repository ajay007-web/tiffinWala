import 'package:equatable/equatable.dart';
import '../../../data/models/plan_model.dart';

class PlansState extends Equatable {
  final List<PlanModel> plans;
  final String selectedPlanId;

  const PlansState({
    required this.plans,
    required this.selectedPlanId,
  });

  PlanModel get selectedPlan =>
      plans.firstWhere((p) => p.id == selectedPlanId, orElse: () => plans.first);

  PlansState copyWith({
    List<PlanModel>? plans,
    String? selectedPlanId,
  }) {
    return PlansState(
      plans: plans ?? this.plans,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
    );
  }

  @override
  List<Object?> get props => [plans, selectedPlanId];
}
