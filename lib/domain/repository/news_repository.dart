import '../../common/base/result.dart';
import '../entity/news/news_result.dart';

abstract interface class NewsRepository {
  Future<Result<NewsResult>> getNewsEverything(String? search,
      String? country, String? category, int page, int pageSize);
}
