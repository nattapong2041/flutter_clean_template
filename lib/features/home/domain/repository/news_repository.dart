import '../entity/news_result.dart';

abstract class NewsRepository {
  Future<NewsResult> getNewsEverything(
      String? search, String? language, String sortBy, int page, int pageSize);
}
