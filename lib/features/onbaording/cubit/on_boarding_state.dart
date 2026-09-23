// ignore_for_file: must_be_immutable

part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  OnBoardingState({this.currentIndex = 0, this.isLastPage = false});
  int currentIndex;
  bool isLastPage;

  OnBoardingState copyWith({int? currentIndex, bool? isLastPage}) {
    return OnBoardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }

  @override
  List<Object?> get props => [currentIndex, isLastPage];
}
