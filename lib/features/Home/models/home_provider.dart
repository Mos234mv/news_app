import 'package:flutter/material.dart';
import 'package:news_app/core/data_source/remote_data/api.config.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider() {
    getTopHeadLine();
    getEveryThing();
  }

  RequestStytasEnum everyThingStutas = RequestStytasEnum.loding;

  bool topHeadlineLoading = true;

  List<NewsArticleModel> newsTopHeadLine = [];
  List<NewsArticleModel> newsEveryThing = [];
  ApiService apiService = ApiService();
  String? errorMessage;
  String? selectedCategory;

  void getTopHeadLine({String? category}) async {
    try {
      Map<String, dynamic> result = await apiService.get(
        ApiConfig.topHeadlines,
        params: {"country": "us", "category": selectedCategory},
      );

      newsTopHeadLine = (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();

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
      Map<String, dynamic> result = await apiService.get(ApiConfig.everyThing, params: {"q": "news"});

      newsEveryThing = (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();

      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = e.toString();
      everyThingStutas = RequestStytasEnum.error;
    }
    notifyListeners();
  }

  void updatSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: selectedCategory);
    notifyListeners();
  }
}
