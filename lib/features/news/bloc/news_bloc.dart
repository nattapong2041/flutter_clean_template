import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/base/pagination.dart';
import '../../../domain/entity/news/news.dart';
import '../../../domain/usecase/news/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase _getNewsUseCase;
  NewsBloc({required GetNewsUseCase getNewsUseCase})
      : _getNewsUseCase = getNewsUseCase,
        super(NewsInitial()) {
    on<NewsFecthData>(_getNewsList);
  }

  Future<void> _getNewsList(
    NewsFecthData event,
    Emitter<NewsState> emit,
  ) async {
    late Pagination pagination;
    if (state is NewsReady && !event.shouldRefresh) {
      final currentState = state as NewsReady;
      pagination = currentState.newsPgiantion;

      if (!pagination.hasNext) return;
    } else {
      pagination = Pagination();
    }

    emit(NewsLoading());

    GetNewsParam params = GetNewsParam(
      null,
      "us",
      null,
      pagination.page,
      pagination.size,
    );
    final newsList = await _getNewsUseCase.execute(params);

    if (newsList.isLeft) {
      emit(NewsError(message: newsList.left.message));
    } else {
      pagination.setNext = newsList.right.totalResults;
      (state is NewsReady && !event.shouldRefresh)
          ? (state as NewsReady).news.addAll(newsList.right.articles)
          : emit(NewsReady(news: newsList.right.articles, newsPgiantion: pagination));
      
      // emit(NewsReady(news: , newsPgiantion: pagination));
    }
  }
}
