import 'package:equatable/equatable.dart';
import '../../../data/models/subscription_model.dart';

class SubscriptionState extends Equatable {
  final SubscriptionModel? subscription;
  final bool isLoading;

  const SubscriptionState({
    this.subscription,
    this.isLoading = false,
  });

  bool get hasActivePlan => subscription != null && subscription!.isActive;

  SubscriptionState copyWith({
    SubscriptionModel? subscription,
    bool? isLoading,
    bool clearSubscription = false,
  }) {
    return SubscriptionState(
      subscription: clearSubscription ? null : (subscription ?? this.subscription),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [subscription, isLoading];
}
