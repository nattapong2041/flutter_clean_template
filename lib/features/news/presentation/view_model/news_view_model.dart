import 'dart:developer';

import '../../../../common/base/base_service.dart';
import '../../../../common/base/base_view_model.dart';
import '../../../../common/base/pagination.dart';
import '../../domain/entity/news.dart';
import '../../domain/usecase/get_news_usecase.dart';

class NewsViewModel extends BaseViewModel {
  final GetNewsUseCase _useCase;
  List<News> _listNews = [];
  Pagination _newsPagination = Pagination(size: 20);

  //init _useCase and call getNews function with shouldRefresh = true
  NewsViewModel({required GetNewsUseCase useCase}) : _useCase = useCase {
    getNews(shouldRefresh: true);
  }

  List<News> get listNews => _listNews;

  set listNews(List<News> list) {
    _listNews = list;
    notifyListeners();
  }

  Future<void> getNews({bool shouldRefresh = false}) async {
    if (apiState == ApiState.loading) return;
    if (shouldRefresh) {
      _listNews.clear();
      _newsPagination = Pagination(size: 20);
    }
    if (!_newsPagination.hasNext) return;
    loadingState();

    GetNewsParam params = GetNewsParam(
      null,
      "us",
      null,
      _newsPagination.page,
      _newsPagination.size,
    );

    await _useCase.execute(params).then((value) {
      _listNews.addAll(value.articles);
      _newsPagination.setNext = value.totalResults;
      completedState();
    }).catchError((onError) {
      log(onError.toString());
      errorState(message: onError.toString());
    });
  }
}
