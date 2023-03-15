import 'dart:convert';
import 'dart:developer';

import '../../../../common/base/api_exception.dart';
import '../../../../common/base/base_service.dart';
import '../model/news_request_model.dart';
import '../model/news_response_model.dart';

class GetNewsService extends BaseService {
  Future<NewsResponseModel> getNewsEverythingService(NewsRequestModel request) {
    log('execute service: ${request.service}');
    return execute(ServiceUrl.everything,
            urlType: UrlType.deufaultUrl,
            request: request.toJson(),
            method: HttpMethod.get,
            needAuth: false)
        .then((resp) {
      return NewsResponseModel.fromJson(jsonDecode(resp));
    }).catchError((onError) {
      if (onError is ApiException) {
        throw onError;
      } else {
        log(onError);
        throw Exception("Error ${request.service}");
      }
    });
  }
}
