import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/repos/news_repos.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepos) : super(HomeState()) {
    getTopHeadLine();
    getEveryThing();
  }
  final NewsRepos newsRepos;
  void getTopHeadLine({String? category}) async {
    try {
      emit(state.copyWith(topheadlinestutas: RequestStytasEnum.loding));
      emit(state.copyWith(categoriesstutas: RequestStytasEnum.loding));

      final article = await newsRepos.getTopHeadLine(
        selectedCategory: state.selectedCategory,
      );

      emit(
        state.copyWith(
          newsTopHeadLine: article,
          topheadlinestutas: RequestStytasEnum.loded,
          categoriesstutas: RequestStytasEnum.loded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          topheadlinestutas: RequestStytasEnum.error,
          categoriesstutas: RequestStytasEnum.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getEveryThing() async {
    try {
      final article = await newsRepos.getEveryThing();

      emit(
        state.copyWith(
          newsEveryThing: article,
          everyThingStutas: RequestStytasEnum.loded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          everyThingStutas: RequestStytasEnum.error,
        ),
      );
    }
  }

  void updatSelectedCategory(String category) {
    emit(state.copyWith(selectedCategory: category));

    getTopHeadLine(category: state.selectedCategory);
  }
}
