import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../common/base/base_service.dart';
import '../../../../common/widget/default_appbar.dart';
import '../view_model/news_view_model.dart';
import 'widget/news_card_shimmer.dart';
import 'widget/news_card_view.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const DefaultAppbar(),
      body: Selector<NewsViewModel, bool>(
        selector: (context, viewModel) {
          return viewModel.listNews.isEmpty &&
              (viewModel.apiState == ApiState.loading);
        },
        builder: (context, shouldShowLoading, child) => shouldShowLoading
            ? const _SkeletonShimmer()
            : const _NewsListView(),
      ),
    );
  }
}

class _NewsListView extends StatefulWidget {
  const _NewsListView();

  @override
  State<_NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<_NewsListView> {
  late final ScrollController _scrollController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >
          (_scrollController.position.maxScrollExtent * 0.7)) {
        context.read<NewsViewModel>().getNews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<NewsViewModel>();
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => viewModel.getNews(shouldRefresh: true),
      child: viewModel.listNews.isEmpty
          ? const _EmptyList()
          : GridView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: viewModel.listNews.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio:
                    (MediaQuery.of(context).size.width / 2) / 300.0,
              ),
              itemBuilder: (context, index) {
                final item = viewModel.listNews[index];
                return NewsCardView(
                  title: item.title,
                  author: item.author,
                  description: item.description,
                  urlToImage: item.urlToImage,
                  publishedAt: item.publishedAt,
                );
              },
            ),
    );
  }
}

class _SkeletonShimmer extends StatelessWidget {
  const _SkeletonShimmer();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (MediaQuery.of(context).size.width / 2) / 300.0,
      ),
      itemBuilder: (context, index) {
        return const NewsCardShimmer();
      },
    );
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => RefreshIndicator(
        onRefresh: () =>
            context.read<NewsViewModel>().getNews(shouldRefresh: true),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth),
            child: const Center(
              child: Text("My Widget"),
            ),
          ),
        ),
      ),
    );
  }
}
