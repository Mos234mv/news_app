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

  /// Add a bookmark
  Future<void> addBookmark(BookmarkModel bookmark) async {
    await bookmarkBox.put(bookmark.url, bookmark);
  }

  /// Alias for addBookmark
  Future<void> saveBookmark(BookmarkModel bookmark) async {
    await addBookmark(bookmark);
  }

  /// Remove a bookmark by article URL
  Future<void> removeBookmark(String url) async {
    await bookmarkBox.delete(url);
  }

  /// Toggle bookmark: adds if not present, removes if already present.
  /// Returns `true` if added, `false` if removed.
  Future<bool> toggleBookmark(BookmarkModel bookmark) async {
    if (isBookmarked(bookmark.url)) {
      await removeBookmark(bookmark.url);
      return false;
    } else {
      await addBookmark(bookmark);
      return true;
    }
  }

  /// Check if an article URL is bookmarked
  bool isBookmarked(String url) {
    return bookmarkBox.containsKey(url);
  }

  /// Get total count of saved bookmarks
  int get bookmarkCount => bookmarkBox.length;

  int getBookmarkCount() => bookmarkBox.length;

  /// Get all bookmarks, sorted from newest to oldest
  List<BookmarkModel> getBookmarks() {
    return bookmarkBox.values.toList().reversed.toList();
  }

  /// Search bookmarks by title, description, or author
  List<BookmarkModel> searchBookmarks(String query) {
    final lowerQuery = query.trim().toLowerCase();
    if (lowerQuery.isEmpty) return getBookmarks();

    return bookmarkBox.values.where((bookmark) {
      final matchesTitle = bookmark.title.toLowerCase().contains(lowerQuery);
      final matchesDesc = bookmark.description?.toLowerCase().contains(lowerQuery) ?? false;
      final matchesAuthor = bookmark.author?.toLowerCase().contains(lowerQuery) ?? false;
      return matchesTitle || matchesDesc || matchesAuthor;
    }).toList().reversed.toList();
  }

  /// Clear all bookmarks
  Future<void> clearAllBookmarks() async {
    await bookmarkBox.clear();
  }

  /// Alias for clearAllBookmarks
  Future<void> clearAll() async {
    await clearAllBookmarks();
  }

  // --- NewsArticleModel Conversion Helpers ---

  /// Convert a BookmarkModel to NewsArticleModel
  NewsArticleModel convertToNewsArticle(BookmarkModel bookmark) {
    return bookmark.toNewsArticle();
  }

  /// Convert a NewsArticleModel to BookmarkModel
  BookmarkModel convertToBookmarkModel(NewsArticleModel article) {
    return BookmarkModel.fromNewsArticle(article);
  }

  /// Add a bookmark directly from a NewsArticleModel
  Future<void> addBookmarkFromArticle(NewsArticleModel article) async {
    await addBookmark(BookmarkModel.fromNewsArticle(article));
  }

  /// Toggle bookmark directly with a NewsArticleModel
  Future<bool> toggleBookmarkFromArticle(NewsArticleModel article) async {
    return await toggleBookmark(BookmarkModel.fromNewsArticle(article));
  }

  /// Get all saved bookmarks directly as NewsArticleModel objects
  List<NewsArticleModel> getBookmarkedArticles() {
    return getBookmarks().map((b) => b.toNewsArticle()).toList();
  }
}
