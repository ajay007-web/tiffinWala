import 'nutrition_model.dart';

class MealModel {
  final String id;
  final String dayOfWeek;
  final String dayShort;
  final String name;
  final String shortName;
  final String description;
  final List<String> items;
  final bool isVegetarian;
  final int calories;
  final String imageAsset;
  final String deliveryTime;
  final NutritionModel nutrition;
  final String? specialBadge;

  const MealModel({
    required this.id,
    required this.dayOfWeek,
    required this.dayShort,
    required this.name,
    required this.shortName,
    required this.description,
    required this.items,
    this.isVegetarian = true,
    required this.calories,
    required this.imageAsset,
    this.deliveryTime = '12:30 PM - 01:30 PM',
    required this.nutrition,
    this.specialBadge,
  });
}
