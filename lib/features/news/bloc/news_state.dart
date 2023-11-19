part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsReady extends NewsState {
  final Pagination newsPagiantion;
  final List<News> news;
  final bool isLoadMore;

  const NewsReady({required this.newsPagiantion, required this.news, this.isLoadMore = false});

  NewsReady copyWith({
    Pagination? newsPagiantion,
    List<News>? news,
    bool? isLoadMore,
  }) {
    return NewsReady(
      newsPagiantion: newsPagiantion ?? this.newsPagiantion,
      news: news ?? this.news,
      isLoadMore: isLoadMore ?? this.isLoadMore,
    );
  }
  
  @override
  List<Object> get props => [news, newsPagiantion];
}

final class NewsError extends NewsState {
  final String message;

  const NewsError({required this.message});

  @override
  List<Object> get props => [message];
}