import '../entity/news_result.dart';
import '../repository/news_repository.dart';

class GetNews {
  final NewsRepository _repository;

  GetNews(this._repository);

  Future<NewsResult> execute(
      String? search, String? language, String sortBy, int page, int pageSize) {
    return _repository.getNewsEverything(
        search, language, sortBy, page, pageSize);
  }
}
