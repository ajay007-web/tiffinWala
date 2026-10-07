import 'package:equatable/equatable.dart';
import '../../../data/models/meal_model.dart';
import '../../../data/models/user_model.dart';

class HomeState extends Equatable {
  final List<MealModel> weeklyMeals;
  final int selectedDayIndex;
  final UserModel user;
  final bool isLoading;

  const HomeState({
    required this.weeklyMeals,
    required this.selectedDayIndex,
    required this.user,
    this.isLoading = false,
  });

  MealModel get selectedMeal => weeklyMeals[selectedDayIndex];
  MealModel get todaysMeal => weeklyMeals[DateTime.now().weekday - 1]; // 1=Mon, 7=Sun

  HomeState copyWith({
    List<MealModel>? weeklyMeals,
    int? selectedDayIndex,
    UserModel? user,
    bool? isLoading,
  }) {
    return HomeState(
      weeklyMeals: weeklyMeals ?? this.weeklyMeals,
      selectedDayIndex: selectedDayIndex ?? this.selectedDayIndex,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [weeklyMeals, selectedDayIndex, user, isLoading];
}
