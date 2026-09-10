import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/remote_data/api.config.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    getTopHeadLine();
    getEveryThing();
  }

  bool topHeadlineLoading = true;
  bool everyThingLoading = true;
  List<NewsArticleModel> newsTopHeadLine = [];
  List<NewsArticleModel> newsEveryThing = [];
  ApiService apiService = ApiService();
  String? errorMessage;

  void getTopHeadLine() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us"},
      );

      newsTopHeadLine = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();

      topHeadlineLoading = false;
      errorMessage = null;
    } catch (e) {
      topHeadlineLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void getEveryThing() async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.everyThing,
        params: {"q": "news"},
      );

      newsEveryThing = (result['articles'] as List)
          .map((e) => NewsArticleModel.fromJson(e))
          .toList();

      everyThingLoading = false;
      errorMessage = null;
    } catch (e) {
      everyThingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
