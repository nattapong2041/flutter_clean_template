part of 'news_bloc.dart';

sealed class NewsState extends Equatable {
  const NewsState();
  
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsReady extends NewsState {
  final Pagination newsPgiantion;
  final List<News> news;

  const NewsReady({required this.newsPgiantion, required this.news});

  @override
  List<Object> get props => [news, newsPgiantion];
}

final class NewsError extends NewsState {
  final String message;

  const NewsError({required this.message});

  @override
  List<Object> get props => [message];
}