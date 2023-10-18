import 'package:dio/dio.dart';

import '../../common/base/service_exception.dart';
import '../../common/extension/either.dart';
import 'remote/request/news/news_request_model.dart';
import 'remote/response/news/news_response_model.dart';

class NewsService {
  final Dio _dio;
  final String _v2Everything = "v2/everything";

  NewsService({required Dio dio}) : _dio = dio;

  Future<Either<ServiceException, NewsResponseModel>> getNewsEverythingService(
      NewsRequestModel request) async {
    try {
      final response = await _dio.get(_v2Everything, queryParameters: request.toJson());
      return Right(NewsResponseModel.fromJson(response.data));
    } on DioException catch (_) {
      return Left(ServerException());
    } catch (e) {
      return Left(DataParsingException());
    }
  }
}
