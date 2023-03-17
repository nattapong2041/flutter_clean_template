import '../entity/news_result.dart';

abstract class NewsRepository {
  Future<NewsResult> getNewsEverything(String? search, String? country,
      String? category, int page, int pageSize);
}
