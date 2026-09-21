import 'package:flutter/material.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/core/mixin/safe_notifier_mixin.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';

class BookmarkController extends ChangeNotifier with SafeNotify {
  final BookmarkRepository _repository;

  RequestStytasEnum status = RequestStytasEnum.loding;
  RequestStytasEnum get bookmarkStatus => status;
  String? errorMessage;

  String getSuccessMessage(bool isAdded) =>
      isAdded ? Constants.bookmarkAddedMessage : Constants.bookmarkRemovedMessage;

  List<BookmarkModel> _bookmarks = [];
  Set<String> _bookmarkedUrls = {};
  TextEditingController searchController = TextEditingController();

  BookmarkController({BookmarkRepository? repository})
      : _repository = repository ?? BookmarkRepository() {
    loadBookmarks();
  }

  /// List of saved BookmarkModel items
  List<BookmarkModel> get bookmarks => _bookmarks;

  /// List of saved bookmarks converted to NewsArticleModel for UI rendering
  List<NewsArticleModel> get bookmarkedArticles =>
      _bookmarks.map((b) => bookmarkToArticle(b)).toList();

  /// Set of bookmarked URLs for fast O(1) checks
  Set<String> get bookmarkedUrls => _bookmarkedUrls;

  /// Total count of bookmarks
  int get bookmarkCount => _bookmarks.length;

  int getBookmarkCount() => _bookmarks.length;

  /// Check if an article URL is currently bookmarked
  bool isBookmarked(String? url) {
    if (url == null || url.isEmpty) return false;
    return _bookmarkedUrls.contains(url);
  }

  /// Load all bookmarks from local Hive storage
  void loadBookmarks() {
    try {
      status = RequestStytasEnum.loding;
      safeNotify();

      _bookmarks = _repository.getBookmarks();
      _bookmarkedUrls = _bookmarks.map((b) => b.url).toSet();
      status = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  /// Add a bookmark from NewsArticleModel
  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      status = RequestStytasEnum.loding;
      safeNotify();

      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
      safeNotify();
    }
  }

  /// Remove a bookmark by article URL
  Future<void> removeBookmark(String url) async {
    try {
      status = RequestStytasEnum.loding;
      safeNotify();

      await _repository.removeBookmark(url);
      loadBookmarks();
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
      safeNotify();
    }
  }

  /// Toggle bookmark status for a NewsArticleModel
  /// Returns `true` if added, `false` if removed
  Future<bool> toggleBookmark(NewsArticleModel article) async {
    try {
      final bool isAdded = await _repository.toggleBookmark(article);
      loadBookmarks();
      return isAdded;
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
      safeNotify();
      return false;
    }
  }

  /// Search bookmarks by query (filters by title, description, or author)
  void searchBookmarks(String query) {
    try {
      status = RequestStytasEnum.loding;
      safeNotify();

      if (query.trim().isEmpty) {
        _bookmarks = _repository.getBookmarks();
      } else {
        _bookmarks = _repository.searchBookmarks(query);
      }
      _bookmarkedUrls = _bookmarks.map((b) => b.url).toSet();
      status = RequestStytasEnum.loded;
      errorMessage = null;
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  /// Clear all bookmarks from Hive storage
  Future<void> clearAllBookmarks() async {
    try {
      status = RequestStytasEnum.loding;
      safeNotify();

      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      status = RequestStytasEnum.error;
      errorMessage = e.toString();
      safeNotify();
    }
  }

  /// Alias for clearAllBookmarks
  Future<void> clearAll() async {
    await clearAllBookmarks();
  }

  /// Convert BookmarkModel to NewsArticleModel
  NewsArticleModel bookmarkToArticle(BookmarkModel bookmark) {
    return _repository.bookmarkToArticle(bookmark);
  }

  /// Convert NewsArticleModel to BookmarkModel
  BookmarkModel articleToBookmark(NewsArticleModel article) {
    return _repository.articleToBookmark(article);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
