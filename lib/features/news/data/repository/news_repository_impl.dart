import '../../domain/entity/news.dart';
import '../../domain/entity/news_result.dart';
import '../../domain/repository/news_repository.dart';
import '../model/news_request_model.dart';
import '../service/get_news_service.dart';

class NewsRepositoryImpl implements NewsRepository {
  final GetNewsService service;

  NewsRepositoryImpl({required this.service});
  @override
  Future<NewsResult> getNewsEverything(String? search, String? country,
      String category, int page, int pageSize) async {
    try {
      final result = await service.getNewsEverythingService(NewsRequestModel(
          search: search,
          country: country,
          category: category,
          page: page,
          pageSize: pageSize));

      return NewsResult(
          result.articles
                  ?.map<News>((article) => News(
                      article.author ?? "",
                      article.title ?? "",
                      article.description ?? "",
                      article.url,
                      article.urlToImage,
                      article.publishedAt,
                      article.content ?? ""))
                  .toList() ??
              [],
          result.totalResults ?? 0);
    } catch (e) {
      rethrow;
    }
  }
}
