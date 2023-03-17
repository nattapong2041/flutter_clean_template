import 'package:flutter_clean_template/common/base/base_use_case.dart';

import '../entity/news_result.dart';
import '../repository/news_repository.dart';

class GetNews implements BaseUseCase<NewsResult, GetNewsParam> {
  final NewsRepository _repository;

  GetNews(this._repository);

  @override
  Future<NewsResult> execute(GetNewsParam params) {
    return _repository.getNewsEverything(params.search, params.country,
        params.category, params.page, params.pageSize);
  }
}

class GetNewsParam {
  GetNewsParam(
      this.search, this.country, this.category, this.page, this.pageSize);
  String? search;
  String? country;
  String category;
  int page;
  int pageSize;
}
