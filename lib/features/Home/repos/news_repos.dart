import 'package:news_app/core/data_source/remote_data/api.config.dart';
import 'package:news_app/core/data_source/remote_data/api_service.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

abstract class BaseNewRepo {
  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory = 'general'});
  Future<List<NewsArticleModel>> getEveryThing();
}

class NewsRepos extends BaseNewRepo {
  NewsRepos(this.apiService);

  final BaseApiService apiService;

  // ignore: annotate_overrides
  Future<List<NewsArticleModel>> getTopHeadLine({String? selectedCategory = 'general'}) async {
    Map<String, dynamic> result = await apiService.get(
      ApiConfig.topHeadlines,
      params: {"country": "us", "category": selectedCategory},
    );

    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }

  // ignore: annotate_overrides
  Future<List<NewsArticleModel>> getEveryThing() async {
    Map<String, dynamic> result = await apiService.get(ApiConfig.everyThing, params: {"q": "news"});

    return (result['articles'] as List).map((e) => NewsArticleModel.fromJson(e)).toList();
  }
}
