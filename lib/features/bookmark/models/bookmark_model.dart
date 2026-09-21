import 'package:hive_ce/hive.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';

part 'bookmark_model.g.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String url;

  @HiveField(2)
  final String? urlToImage;

  @HiveField(3)
  final String? author;

  @HiveField(4)
  final String? description;

  @HiveField(5)
  final String? content;

  @HiveField(6)
  final DateTime publishedAt;

  @HiveField(7)
  final String sourceName;

  @HiveField(8)
  final DateTime bookmarkedAt;

  BookmarkModel({
    required this.title,
    required this.url,
    this.urlToImage,
    this.author,
    this.description,
    this.content,
    required this.publishedAt,
    this.sourceName = '',
    DateTime? bookmarkedAt,
  }) : bookmarkedAt = bookmarkedAt ?? DateTime.now();

  factory BookmarkModel.fromNewsArticle(NewsArticleModel article, {DateTime? bookmarkedAt}) {
    return BookmarkModel(
      title: article.title,
      url: article.url,
      urlToImage: article.urlToImage,
      author: article.author,
      description: article.description,
      content: article.content,
      publishedAt: article.publishedAt,
      sourceName: article.source.name,
      bookmarkedAt: bookmarkedAt ?? DateTime.now(),
    );
  }

  NewsArticleModel toNewsArticle() {
    return NewsArticleModel(
      source: Source(name: sourceName),
      title: title,
      url: url,
      urlToImage: urlToImage,
      author: author,
      description: description,
      content: content,
      publishedAt: publishedAt,
    );
  }
}
