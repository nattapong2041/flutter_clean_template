import 'package:equatable/equatable.dart';

import 'news.dart';

class NewsResult extends Equatable{
  final int totalResults;
  final List<News> articles;

  const NewsResult(this.articles, this.totalResults);
  
  @override
  List<Object?> get props => [totalResults, articles];
}
