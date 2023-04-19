import 'package:flutter/material.dart';
import 'package:flutter_clean_template/common/base/base_service.dart';
import 'package:flutter_clean_template/common/extension/app_theme.dart';
import 'package:flutter_clean_template/features/news/domain/entity/news.dart';
import 'package:flutter_clean_template/features/news/presentation/view/news_screen.dart';
import 'package:flutter_clean_template/features/news/presentation/view/widget/news_card_shimmer.dart';
import 'package:flutter_clean_template/features/news/presentation/view/widget/news_card_view.dart';
import 'package:flutter_clean_template/features/news/presentation/view_model/news_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<NewsViewModel>()])
import 'news_screen_test.mocks.dart';

void main() {
  late MockNewsViewModel mockNewsViewModel;

  List<News> newsList = [
    News(
      'John Doe',
      'Breaking News',
      'This is a breaking news article.',
      'https://example.com/article',
      'https://example.com/article/image.jpg',
      DateTime.now(),
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    News(
      'John Doe2',
      'Breaking News2',
      'This is a breaking news article.',
      'https://example.com/article',
      'https://example.com/article/image.jpg',
      DateTime.now(),
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
  ];

  List<News> emptyList = [];

  setUp(() {
    mockNewsViewModel = MockNewsViewModel();
  });

  Widget createNewsScreen() {
    return ChangeNotifierProvider<NewsViewModel>(
      create: (_) => mockNewsViewModel,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const NewsScreen(),
        theme: AppTheme.mainTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }

  testWidgets('NewsScreen displays with data', (WidgetTester tester) async {
    //arrange
    when((mockNewsViewModel.apiState)).thenReturn(ApiState.completed);
    when((mockNewsViewModel.listNews)).thenReturn(newsList);

    // act
    await tester.pumpWidget(createNewsScreen());

    // assert
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(NewsCardView), findsWidgets);
    expect(find.byType(NewsCardShimmer), findsNothing);
  });

  testWidgets('NewsScreen displays with empty data',
      (WidgetTester tester) async {
    //arrange
    when((mockNewsViewModel.apiState)).thenReturn(ApiState.completed);
    when((mockNewsViewModel.listNews)).thenReturn(emptyList);

    // act
    await tester.pumpWidget(createNewsScreen());

    // assert
    expect(find.byType(GridView), findsNothing);
    expect(find.byType(NewsCardView), findsNothing);
    expect(find.byType(NewsCardShimmer), findsNothing);
  });

  testWidgets('NewsScreen displays with loading', (WidgetTester tester) async {
    //arrange
    when((mockNewsViewModel.apiState)).thenReturn(ApiState.loading);
    when((mockNewsViewModel.listNews)).thenReturn(emptyList);

    // act
    await tester.pumpWidget(createNewsScreen());

    // assert
    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(NewsCardView), findsNothing);
    expect(find.byType(NewsCardShimmer), findsWidgets);
  });
}
