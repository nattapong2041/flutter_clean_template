import 'dart:developer';

import '../../common/base/base_response.dart';
import '../../common/base/service_exception.dart';
import '../../common/extension/either.dart';
import '../../domain/entity/news/news.dart';
import '../../domain/entity/news/news_result.dart';
import '../../domain/repository/news_repository.dart';
import '../service/news_service.dart';
import '../service/remote/request/news/news_request_model.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsService service;

  NewsRepositoryImpl({required this.service});

  @override
  Future<Either<ServiceException, NewsResult>> getNewsEverything(String? search,
      String? country, String? category, int page, int pageSize) async {
    final response = await service.getNewsEverythingService(NewsRequestModel(
        search: search,
        country: country,
        category: category,
        page: page,
        pageSize: pageSize));

    if (response.isLeft) {
      return Left(response.left);
    } else {
      try {
        if (response.right.statusCode == StatusCode.success) {
          return Right(NewsResult(
              response.right.articles!
                  .map<News>((e) => News(
                      e.author,
                      e.title ?? "",
                      e.description ?? "",
                      e.url,
                      e.urlToImage,
                      e.publishedAt,
                      e.content ?? ""))
                  .toList(),
              response.right.totalResults!));
        } else {
          return Left(APIException(
            statusCode: response.right.statusCode,
            message: response.right.message,
          ));
        }
      } catch (e) {
        log(e.toString());
        return Left(DataParsingException());
      }
    }
  }
}
