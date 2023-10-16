import '../entity/news/news_result.dart';

import '../../common/base/service_exception.dart';
import '../../common/extension/either.dart';

abstract interface class NewsRepository {
  Future<Either<ServiceException, NewsResult>> getNewsEverything(String? search,
      String? country, String? category, int page, int pageSize);
}
