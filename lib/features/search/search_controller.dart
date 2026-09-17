import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/mixin/safe_notifier_mixin.dart';
import 'package:news_app/core/repos/news_repos.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotify {
  final BaseNewRepo newsRepo;

  TextEditingController searchController = TextEditingController();

  SearchScreenController(this.newsRepo);
  RequestStytasEnum everyThingStutas = RequestStytasEnum.loding;
  List<NewsArticleModel> newsEveryThing = [];
  String? errorMessage;

  void getEveryThing() async {
    try {
      newsEveryThing = await newsRepo.getEveryThing(query: searchController.text);
      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      everyThingStutas = RequestStytasEnum.loded;
      errorMessage = e.toString();
      everyThingStutas = RequestStytasEnum.error;
    }
    safeNotify();
  }
}
