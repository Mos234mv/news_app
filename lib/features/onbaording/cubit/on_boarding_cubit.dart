import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState());

  void onPageChanged(int index) {
    if (index == 2) {
      emit(state.copyWith(isLastPage: true, currentIndex: index));
    } else {
      emit(state.copyWith(currentIndex: index, isLastPage: false));
    }
  }
}
