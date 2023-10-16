part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

final class NewsFecthData extends NewsEvent {
  final bool shouldRefresh;

  const NewsFecthData({this.shouldRefresh = false});

  @override
  List<Object> get props => [shouldRefresh];
}
