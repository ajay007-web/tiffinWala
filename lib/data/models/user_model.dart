import 'address_model.dart';
import 'subscription_model.dart';

class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final AddressModel? defaultAddress;
  final SubscriptionModel? activeSubscription;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.defaultAddress,
    this.activeSubscription,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    AddressModel? defaultAddress,
    SubscriptionModel? activeSubscription,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      activeSubscription: activeSubscription ?? this.activeSubscription,
    );
  }
}
