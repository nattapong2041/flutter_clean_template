import 'package:dio/dio.dart';

import '../../../common/base/result.dart';
import '../../../common/base/service_exception.dart';
import 'response/news/news_response_model.dart';

class NewsRemote {
  final Dio _dio;

  NewsRemote({required Dio dio}) : _dio = dio;

  Future<Result<NewsResponseModel>> getNewsEverythingService(Map<String, dynamic> request) async {
    try {
      final response = await _dio.get('v2/everything', queryParameters: request);
      return Success(data: NewsResponseModel.fromJson(response.data));
    } on DioException catch (err) {
      return Failure(exception: ServerException(message: err.message));
    } catch (e) {
      return Failure(exception: ServerException());
    }
  }
}