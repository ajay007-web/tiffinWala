import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/mock/mock_meals.dart';
import '../../../data/mock/mock_user.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          weeklyMeals: mockWeeklyMeals,
          selectedDayIndex: (DateTime.now().weekday - 1).clamp(0, 6),
          user: mockCurrentUser,
        ));

  void selectDay(int index) {
    if (index >= 0 && index < state.weeklyMeals.length) {
      emit(state.copyWith(selectedDayIndex: index));
    }
  }

  void updateUser(dynamic updatedUser) {
    emit(state.copyWith(user: updatedUser));
  }
}
