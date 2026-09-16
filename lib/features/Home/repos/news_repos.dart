import 'package:news_app/core/data_source/remote_data/api.config.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

class NewsRepos {
  ApiService apiService = ApiService();

  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory = 'general'}) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  Future<List<NewsArticleModel>> getEveryThing() async {
    Map<String, dynamic> result = await apiService.get(ApiConfig.everyThing, params: {"q": "news"});

    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}
