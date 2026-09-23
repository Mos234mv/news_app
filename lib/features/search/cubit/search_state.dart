part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.status = RequestStytasEnum.loded,
    this.newsEveryThing = const [],
    this.errorMessage,
  });

  final RequestStytasEnum status;
  final List<NewsArticleModel> newsEveryThing;
  final String? errorMessage;

  RequestStytasEnum get everyThingStutas => status;

  SearchState copyWith({
    RequestStytasEnum? status,
    List<NewsArticleModel>? newsEveryThing,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SearchState(
      status: status ?? this.status,
      newsEveryThing: newsEveryThing ?? this.newsEveryThing,
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, newsEveryThing, errorMessage];
}
