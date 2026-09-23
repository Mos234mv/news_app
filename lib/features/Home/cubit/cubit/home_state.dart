// ignore_for_file: unnecessary_this, prefer_const_constructors_in_immutables

part of 'home_cubit.dart';

class HomeState extends Equatable {
  HomeState({
    this.everyThingStutas = RequestStytasEnum.loding,
    this.topheadlinestutas = RequestStytasEnum.loding,
    this.categoriesstutas = RequestStytasEnum.loding,
    this.newsTopHeadLine = const [],
    this.newsEveryThing = const [],
    this.errorMessage,
    this.selectedCategory,
  });

  final RequestStytasEnum everyThingStutas;
  final RequestStytasEnum topheadlinestutas;
  final RequestStytasEnum categoriesstutas;
  final List<NewsArticleModel> newsTopHeadLine;
  final List<NewsArticleModel> newsEveryThing;

  final String? errorMessage;
  final String? selectedCategory;

  HomeState copyWith({
    RequestStytasEnum? everyThingStutas,
    RequestStytasEnum? topheadlinestutas,
    RequestStytasEnum? categoriesstutas,
    List<NewsArticleModel>? newsTopHeadLine,
    List<NewsArticleModel>? newsEveryThing,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return HomeState(
      everyThingStutas: everyThingStutas ?? this.everyThingStutas,
      topheadlinestutas: topheadlinestutas ?? this.topheadlinestutas,
      categoriesstutas: categoriesstutas ?? this.categoriesstutas,
      newsTopHeadLine: newsTopHeadLine ?? this.newsTopHeadLine,
      newsEveryThing: newsEveryThing ?? this.newsEveryThing,
      errorMessage: errorMessage, // تم تعديلها لتستقبل القيمة الجديدة أو القديمة
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
    everyThingStutas,
    topheadlinestutas,
    categoriesstutas,
    newsTopHeadLine,
    newsEveryThing,
    errorMessage,
    selectedCategory,
  ];
}
