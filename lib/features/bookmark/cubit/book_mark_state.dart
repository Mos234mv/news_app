part of 'book_mark_cubit.dart';

class BookMarkState extends Equatable {
  const BookMarkState({
    this.status = RequestStytasEnum.loding,
    this.bookmarks = const [],
    this.bookmarkedUrls = const {},
    this.errorMessage,
  });

  final RequestStytasEnum status;
  final List<BookmarkModel> bookmarks;
  final Set<String> bookmarkedUrls;
  final String? errorMessage;

  RequestStytasEnum get bookmarkStatus => status;
  int get bookmarkCount => bookmarks.length;

  List<NewsArticleModel> get bookmarkedArticles =>
      bookmarks.map((b) => BookmarkRepository().bookmarkToArticle(b)).toList();

  bool isBookmarked(String? url) {
    if (url == null || url.isEmpty) return false;
    return bookmarkedUrls.contains(url);
  }

  BookMarkState copyWith({
    RequestStytasEnum? status,
    List<BookmarkModel>? bookmarks,
    Set<String>? bookmarkedUrls,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return BookMarkState(
      status: status ?? this.status,
      bookmarks: bookmarks ?? this.bookmarks,
      bookmarkedUrls: bookmarkedUrls ?? this.bookmarkedUrls,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, bookmarks, bookmarkedUrls, errorMessage];
}
