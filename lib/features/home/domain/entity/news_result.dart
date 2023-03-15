import 'news.dart';

class NewsResult {
  int totalResults;
  List<News> articles;

  NewsResult(this.articles, this.totalResults);
}
