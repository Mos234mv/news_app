import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/repos/news_repos.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final BaseNewRepo newsRepo;
  final TextEditingController searchController = TextEditingController();

  SearchCubit(this.newsRepo) : super(const SearchState());

  void getEveryThing([String? query]) async {
    final String searchText = query ?? searchController.text;
    if (searchText.trim().isEmpty) {
      emit(
        state.copyWith(
          status: RequestStytasEnum.loded,
          newsEveryThing: const [],
          clearErrorMessage: true,
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));
      final news = await newsRepo.getEveryThing(query: searchText);
      emit(
        state.copyWith(
          status: RequestStytasEnum.loded,
          newsEveryThing: news,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
