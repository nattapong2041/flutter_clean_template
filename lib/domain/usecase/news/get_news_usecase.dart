import '../../../common/base/base_use_case.dart';
import '../../../common/base/result.dart';
import '../../entity/news/news_result.dart';
import '../../repository/news_repository.dart';

class GetNewsUseCase implements BaseUseCase<NewsResult, GetNewsParam> {
  final NewsRepository _repository;

  GetNewsUseCase({required NewsRepository repository})
      : _repository = repository;

  @override
  Future<Result<NewsResult>> call(GetNewsParam param) {
    return _repository.getNewsEverything(param.search, param.country,
        param.category, param.page, param.pageSize);
  }
}

class GetNewsParam {
  GetNewsParam(
      this.search, this.country, this.category, this.page, this.pageSize);
  String? search;
  String? country;
  String? category;
  int page;
  int pageSize;
}
