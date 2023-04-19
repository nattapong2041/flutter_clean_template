import 'package:flutter_clean_template/features/news/domain/entity/news.dart';
import 'package:flutter_clean_template/features/news/domain/entity/news_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_clean_template/features/news/domain/usecase/get_news_usecase.dart';
import 'package:flutter_clean_template/features/news/presentation/view_model/news_view_model.dart';

@GenerateNiceMocks([MockSpec<GetNewsUseCase>()])
import 'news_view_model_test.mocks.dart';

void main() {
  group('NewsViewModel', () {
    late NewsViewModel viewModel;
    late MockGetNewsUseCase mockGetNewsUseCase;

    //mock newsresult empty and with data
    News news1 = News(
      'John Doe',
      'Breaking News',
      'This is a breaking news article.',
      'https://example.com/article',
      'https://example.com/article/image.jpg',
      DateTime.now(),
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    );
    NewsResult newsResult1 = NewsResult([], 0);
    NewsResult newsResult2 = NewsResult([news1], 1);

    setUp(() {
      mockGetNewsUseCase = MockGetNewsUseCase();
      viewModel = NewsViewModel(useCase: mockGetNewsUseCase);
    });

    test('should call usecase', () async {
      when(mockGetNewsUseCase.execute(any))
          .thenAnswer((_) async => newsResult2);

      await viewModel.getNews(shouldRefresh: true);

      verify(mockGetNewsUseCase.execute(any));
      expect(viewModel.listNews.contains(news1), true);
    });
  });
}
