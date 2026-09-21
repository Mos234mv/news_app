import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';

class BookmarkRepository {
  BookmarkRepository._internal();
  static final BookmarkRepository _instance = BookmarkRepository._internal();
  factory BookmarkRepository() => _instance;

  Box<BookmarkModel>? _bookmarkBox;

  Box<BookmarkModel> get bookmarkBox {
    if (_bookmarkBox == null) {
      throw Exception("BookmarkRepository not initialized");
    }
    return _bookmarkBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookmarkModelAdapter());
    }

    _bookmarkBox = await Hive.openBox<BookmarkModel>(Constants.bookmarkBox);
  }

  /// Add a bookmark from NewsArticleModel
  Future<void> addBookmark(NewsArticleModel article) async {
    final bookmark = BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
      sourceName: article.source.name,
    );

    await bookmarkBox.put(article.url, bookmark);
  }

  /// Remove a bookmark by article URL
  Future<void> removeBookmark(String url) async {
    await bookmarkBox.delete(url);
  }

  /// Toggle bookmark: adds if not present, removes if already present.
  /// Returns `true` if added, `false` if removed.
  Future<bool> toggleBookmark(NewsArticleModel article) async {
    if (isBookmarked(article.url)) {
      await removeBookmark(article.url);
      return false;
    } else {
      await addBookmark(article);
      return true;
    }
  }

  /// Check if an article URL is bookmarked
  bool isBookmarked(String url) {
    return bookmarkBox.containsKey(url);
  }

  /// Get total count of saved bookmarks
  int get bookmarkCount => bookmarkBox.length;

  int getBookmarkCount() {
    return bookmarkBox.length;
  }

  /// Get all bookmarks sorted from newest to oldest
  List<BookmarkModel> getBookmarks() {
    return bookmarkBox.values.toList()
      ..sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));
  }

  /// Get all bookmarked articles as NewsArticleModel
  List<NewsArticleModel> getBookmarkedArticles() {
    return getBookmarks().map((b) => bookmarkToArticle(b)).toList();
  }

  /// Search bookmarks by title, description, or author
  List<BookmarkModel> searchBookmarks(String query) {
    final lowercaseQuery = query.toLowerCase();
    return bookmarkBox.values.where((bookmark) {
      final titleMatch = bookmark.title.toLowerCase().contains(lowercaseQuery);
      final descriptionMatch =
          bookmark.description?.toLowerCase().contains(lowercaseQuery) ?? false;
      final authorMatch =
          bookmark.author?.toLowerCase().contains(lowercaseQuery) ?? false;

      return titleMatch || descriptionMatch || authorMatch;
    }).toList()
      ..sort((a, b) => b.bookmarkedAt.compareTo(a.bookmarkedAt));
  }

  /// Clear all bookmarks
  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }

  /// Alias for clearAllBookmarks
  Future<void> clearAll() async {
    await clearAllBookmarks();
  }

  /// convert BookmarkModel to NewsArticleModel
  NewsArticleModel bookmarkToArticle(BookmarkModel bookmark) {
    return NewsArticleModel(
      author: bookmark.author,
      title: bookmark.title,
      description: bookmark.description,
      url: bookmark.url,
      urlToImage: bookmark.urlToImage,
      publishedAt: bookmark.publishedAt,
      content: bookmark.content,
      source: Source(name: bookmark.sourceName),
    );
  }

  /// convert NewsArticleModel to BookmarkModel
  BookmarkModel articleToBookmark(NewsArticleModel article) {
    return BookmarkModel(
      author: article.author,
      title: article.title,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
      bookmarkedAt: DateTime.now(),
      sourceName: article.source.name,
    );
  }
}
