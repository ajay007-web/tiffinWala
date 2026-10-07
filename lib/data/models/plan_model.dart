class PlanModel {
  final String id;
  final String name;
  final int mealCount;
  final double pricePerMeal;
  final String? badge;
  final String subtitle;
  final double discountPercent;
  final double deliveryCharge;
  final List<String> features;

  const PlanModel({
    required this.id,
    required this.name,
    required this.mealCount,
    this.pricePerMeal = 120.0,
    this.badge,
    required this.subtitle,
    this.discountPercent = 0.0,
    this.deliveryCharge = 0.0,
    required this.features,
  });

  double get subtotal => mealCount * pricePerMeal;
  double get discountAmount => subtotal * (discountPercent / 100);
  double get total => subtotal - discountAmount + deliveryCharge;
}
