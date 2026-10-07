import '../models/address_model.dart';
import '../models/subscription_model.dart';
import '../models/user_model.dart';
import 'mock_plans.dart';

const AddressModel mockDefaultAddress = AddressModel(
  fullName: 'Ajay Kumar',
  phone: '+91 98765 43210',
  flatOrBuilding: 'Flat 402, Lotus Tower B',
  areaOrStreet: 'Green Glen Layout, Outer Ring Road',
  city: 'Bengaluru',
  pincode: '560103',
  tag: 'Home',
);

final SubscriptionModel mockActiveSubscription = SubscriptionModel(
  plan: mockPlans[1], // 20 Meal Plan
  totalMeals: 20,
  consumedMeals: 8,
  startDate: DateTime.now().subtract(const Duration(days: 8)),
  endDate: DateTime.now().add(const Duration(days: 12)),
  deliveryAddress: mockDefaultAddress,
  isActive: true,
  deliveredDates: List.generate(
    8,
    (index) => DateTime.now().subtract(Duration(days: index + 1)),
  ),
);

final UserModel mockCurrentUser = UserModel(
  id: 'user_001',
  name: 'Ajay',
  phone: '+91 98765 43210',
  email: 'ajay.kumar@example.com',
  defaultAddress: mockDefaultAddress,
  activeSubscription: mockActiveSubscription,
);
