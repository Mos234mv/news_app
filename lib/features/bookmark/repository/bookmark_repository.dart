import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/constant/constants.dart';
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

  Future<void> saveBookmark(BookmarkModel bookmark) async {
    await bookmarkBox.put(bookmark.url, bookmark);
  }

  Future<void> removeBookmark(String url) async {
    await bookmarkBox.delete(url);
  }

  bool isBookmarked(String url) {
    return bookmarkBox.containsKey(url);
  }

  List<BookmarkModel> getBookmarks() {
    return bookmarkBox.values.toList().reversed.toList();
  }

  Future<void> clearAll() async {
    await bookmarkBox.clear();
  }
}
