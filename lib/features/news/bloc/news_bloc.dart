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
    if(state is NewsLoading) return;
    
    if (state is NewsReady && !event.shouldRefresh) {
      final currentState = state as NewsReady;
      if(currentState.isLoadMore) return;
      pagination = currentState.newsPagiantion;
      emit(currentState.copyWith(isLoadMore: true));
      if (!pagination.hasNext) return;
    } else {
      pagination = Pagination();
      emit(NewsLoading());
    }
  
    GetNewsParam params = GetNewsParam(
      "bitcoin",
      null,
      null,
      pagination.page,
      pagination.size,
    );
    final newsList = await _getNewsUseCase.call(params);

    if (newsList.isFailure) {
      emit(NewsError(message: newsList.asFailure.exception.message));
    } else {
      pagination.setNext = newsList.asSuccess.data!.totalResults;
      (state is NewsReady && !event.shouldRefresh)
          ? (state as NewsReady).news.addAll(newsList.asSuccess.data!.articles)
          : emit(NewsReady(news: newsList.asSuccess.data!.articles, newsPagiantion: pagination));

      // emit(NewsReady(news: , newsPgiantion: pagination));
    }
  }
}
