import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constant/constants.dart';
import 'package:news_app/core/enums/request_stytas_enum.dart';
import 'package:news_app/features/Home/models/news_article_model.dart';
import 'package:news_app/features/bookmark/models/bookmark_model.dart';
import 'package:news_app/features/bookmark/repository/bookmark_repository.dart';

part 'book_mark_state.dart';

class BookMarkCubit extends Cubit<BookMarkState> {
  final BookmarkRepository _repository;
  final TextEditingController searchController = TextEditingController();

  BookMarkCubit({BookmarkRepository? repository})
    : _repository = repository ?? BookmarkRepository(),
      super(const BookMarkState()) {
    loadBookmarks();
  }

  String getSuccessMessage(bool isAdded) =>
      isAdded ? Constants.bookmarkAddedMessage : Constants.bookmarkRemovedMessage;

  /// List of saved BookmarkModel items
  List<BookmarkModel> get bookmarks => state.bookmarks;

  /// List of saved bookmarks converted to NewsArticleModel for UI rendering
  List<NewsArticleModel> get bookmarkedArticles =>
      state.bookmarks.map((b) => bookmarkToArticle(b)).toList();

  /// Set of bookmarked URLs for fast O(1) checks
  Set<String> get bookmarkedUrls => state.bookmarkedUrls;

  /// Total count of bookmarks
  int get bookmarkCount => state.bookmarks.length;

  int getBookmarkCount() => state.bookmarks.length;

  /// Check if an article URL is currently bookmarked
  bool isBookmarked(String? url) {
    if (url == null || url.isEmpty) return false;
    return state.bookmarkedUrls.contains(url);
  }

  /// Load all bookmarks from local Hive storage
  void loadBookmarks() {
    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));

      final bookmarks = _repository.getBookmarks();
      final bookmarkedUrls = bookmarks.map((b) => b.url).toSet();

      emit(
        BookMarkState(
          status: RequestStytasEnum.loded,
          bookmarks: bookmarks,
          bookmarkedUrls: bookmarkedUrls,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
    }
  }

  /// Add a bookmark from NewsArticleModel
  Future<void> addBookmark(NewsArticleModel article) async {
    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));

      await _repository.addBookmark(article);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
    }
  }

  /// Remove a bookmark by article URL
  Future<void> removeBookmark(String url) async {
    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));

      await _repository.removeBookmark(url);
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
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
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
      return false;
    }
  }

  /// Search bookmarks by query (filters by title, description, or author)
  void searchBookmarks(String query) {
    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));

      final List<BookmarkModel> bookmarks;
      if (query.trim().isEmpty) {
        bookmarks = _repository.getBookmarks();
      } else {
        bookmarks = _repository.searchBookmarks(query);
      }
      final bookmarkedUrls = bookmarks.map((b) => b.url).toSet();

      emit(
        BookMarkState(
          status: RequestStytasEnum.loded,
          bookmarks: bookmarks,
          bookmarkedUrls: bookmarkedUrls,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
    }
  }

  /// Clear all bookmarks from Hive storage
  Future<void> clearAllBookmarks() async {
    try {
      emit(state.copyWith(status: RequestStytasEnum.loding));

      await _repository.clearAllBookmarks();
      loadBookmarks();
    } catch (e) {
      emit(state.copyWith(status: RequestStytasEnum.error, errorMessage: e.toString()));
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
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
