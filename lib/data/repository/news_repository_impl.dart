import '../../common/base/result.dart';
import '../../domain/entity/news/news.dart';
import '../../domain/entity/news/news_result.dart';
import '../../domain/repository/news_repository.dart';
import '../service/remote/news_remote.dart';
import '../service/remote/request/news/news_request_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemote service;

  NewsRepositoryImpl({required this.service});

  @override
  Future<Result<NewsResult>> getNewsEverything(
      String? search, String? country, String? category, int page, int pageSize) async {
    final response = await service.getNewsEverythingService(NewsRequestModel(
            search: search, country: country, category: category, page: page, pageSize: pageSize)
        .toJson());

    if (response.isSuccess) {
      return Success(
          data: NewsResult(
        totalResults: response.asSuccess.data?.totalResults ?? 0,
        articles: response.asSuccess.data?.articles
                ?.map(
                  (e) => News(
                    author: e.author,
                    title: e.title ?? "",
                    description: e.description ?? "",
                    url: e.url,
                    urlToImage: e.urlToImage,
                    publishedAt: e.publishedAt,
                    content: e.content ?? "",
                  ),
                )
                .toList() ??
            [],
      ));
    } else {
      return Failure(exception: response.asFailure.exception);
    }
  }
}
