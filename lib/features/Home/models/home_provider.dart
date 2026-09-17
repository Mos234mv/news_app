// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/mixin/safe_notifier_mixin.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/core/repos/news_repos.dart';

class HomeProvider extends ChangeNotifier with SafeNotify {
  HomeProvider(this.newsRepos) {
    getTopHeadLine();
    getEveryThing();
  }

  RequestStytasEnum everyThingStutas = RequestStytasEnum.loding;

  RequestStytasEnum topheadlinestutas = RequestStytasEnum.loding;
  RequestStytasEnum categoriesstutas = RequestStytasEnum.loding;
  List<NewsArticleModel> newsTopHeadLine = [];
  List<NewsArticleModel> newsEveryThing = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;
  final NewsRepos newsRepos;

  void getTopHeadLine({String? category}) async {
    try {
      topheadlinestutas = RequestStytasEnum.loding;
      categoriesstutas = RequestStytasEnum.loding;

      safeNotify();
      newsTopHeadLine = await newsRepos.getTopHeadLine(selectedCategory: selectedCategory);
      topheadlinestutas = RequestStytasEnum.loded;
      categoriesstutas = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      topheadlinestutas = RequestStytasEnum.error;
      categoriesstutas = RequestStytasEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void getEveryThing() async {
    try {
      newsEveryThing = await newsRepos.getEveryThing();
      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = e.toString();
      everyThingStutas = RequestStytasEnum.error;
    }
    safeNotify();
  }

  void updatSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    safeNotify();
  }
}
